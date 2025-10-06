import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:FitVise/Global.dart';
import 'package:FitVise/Pages/Classroom/classroom_page.dart';

final supabase = Supabase.instance.client;

Future<void> saveUserInfo() async {
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception('No logged-in user');

  await supabase.from('profiles').upsert({
    'id': user.id,
    'email': currentEmail,
    'username': currentUsername,
    'height': currentHeight,
    'weight': currentWeight,
    'status': userStatus,
    'is_teacher': isTeacher,
    'is_premium': isPremium,
    'class_code': classCode,
  });
}

Future<void> loadUserInfo() async {
  final user = supabase.auth.currentUser;
  if (user == null) return;

  final response =
      await supabase.from('profiles').select().eq('id', user.id).maybeSingle();

  if (response != null) {
    currentEmail = response['email'] ?? "";
    currentUsername = response['username'] ?? "user";
    currentHeight = response['height'];
    currentWeight = response['weight'];
    userStatus = response['status'] ?? "Normal";
    isTeacher = response['is_teacher'] ?? false;
    isPremium = response['is_premium'] ?? false;
    classCode = response['class_code'] ?? "";
  }
}

/// Classroom related functions

Future<void> createClass(String name, String code) async {
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception("No logged-in user");

  await supabase.from("classrooms").upsert({
    'name': name,
    'code': code,
    'teacher_id': user.id,
  });
}

Future<void> loadClassData(String code) async {
  // Implement loading class data logic here
  final user = supabase.auth.currentUser;
  if (user == null) return;

  final response =
      await supabase.from('classrooms').select().eq('code', code).maybeSingle();

  className = response!['name'] ?? "No class joined";
  classCode = response['code'] ?? "XXXXXX";
  teacherId = response['teacher_id'] ?? "No id assigned";
  announcementTitle = response['text'] ?? "No announcements yet";

  //update clasroom_members table
  if (isTeacher == false) {
    final memberResponse = await supabase
        .from('classroom_members')
        .select()
        .eq('student_id', user.id)
        .maybeSingle();

    if (memberResponse == null) {
      await supabase.from('classroom_members').insert({
        'class_code': classCode,
        'student_id': user.id,
        'name': currentUsername,
      });
    }
  }

  //assign teacher name and email
  final teacherResponse = await supabase
      .from('profiles')
      .select()
      .eq('id', teacherId)
      .maybeSingle();
  if (teacherResponse != null) {
    teacherName = teacherResponse['username'] ?? "No teacher assigned";
    teacherEmail = teacherResponse['email'] ?? "No email assigned";
  }
}

// announcement update function
Future<void> updateAnnouncement(String code, String title) async {
  // Update the announcement text
  await supabase.from('classrooms').update({'text': title}).eq('code', code);
  loadClassData(code);
}

Future<void> deleteClass(String code) async {
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception("No logged-in user");

  // Only the teacher can delete the class
  final response =
      await supabase.from('classrooms').select().eq('code', code).maybeSingle();

  if (response != null && response['teacher_id'] == user.id) {
    await supabase.from('classrooms').delete().eq('code', code);
    await supabase.from('classroom_members').delete().eq('class_code', code);
  } else {
    throw Exception("Only the teacher can delete the class");
  }
}

Future<void> leaveClass() async {
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception("No logged-in user");

  // Only students can leave the class
  await supabase.from('classroom_members').delete().eq('student_id', user.id);
  saveUserInfo();
}

/// Fetch all students with the same class code
Future<List<String>> getStudentsWithSameCode(String code) async {
  try {
    final List<Map<String, dynamic>> response = await Supabase.instance.client
        .from('classroom_members')
        .select()
        .eq('class_code', code);

    final List<String> usernames =
        response.map((row) => row['name'] as String).toList();

    return usernames;
  } catch (error) {
    return [];
  }
}

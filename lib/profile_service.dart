import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:FitVise/Global.dart';
import 'package:FitVise/Pages/Classroom/classroom_page.dart';

final supabase = Supabase.instance.client;

/// Save the current user info to Supabase
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

/// Load the current user's profile info from Supabase
Future<void> loadUserInfo() async {
  final user = supabase.auth.currentUser;
  if (user == null) return;

  final response = await supabase
      .from('profiles')
      .select()
      .eq('id', user.id)
      .maybeSingle();

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

/// Classroom-related functions
Future<void> createClass(String name, String code) async {
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception("No logged-in user");

  await supabase.from("classrooms").upsert({
    'name': name,
    'code': code,
    'teacher_id': user.id,
    'tasks': [], // initialize empty task list
    'text': 'No announcements yet',
  });
}

Future<void> loadClassData(String code) async {
  final user = supabase.auth.currentUser;
  if (user == null) return;

  final response = await supabase
      .from('classrooms')
      .select()
      .eq('code', code)
      .maybeSingle();

  if (response == null) throw Exception("Class not found");

  className = response['name'] ?? "No class joined";
  classCode = response['code'] ?? "XXXXXX";
  teacherId = response['teacher_id'] ?? "No id assigned";
  announcementTitle = response['text'] ?? "No announcements yet";

  // 🔹 Load tasks from Supabase (safe cast)
  if (response['tasks'] != null) {
    final List<dynamic> tasksFromDB = response['tasks'];
    task = tasksFromDB.map((t) => Map<String, dynamic>.from(t as Map)).toList();
  } else {
    task = [];
  }

  // 🔹 If student, register to classroom_members
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

  // 🔹 Assign teacher info
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

/// 🔸 Load students data from Supabase
Future<void> loadStudentsData(String code) async {
  final user = supabase.auth.currentUser;
  if (user == null) return;

  final response = await supabase
      .from('profiles')
      .select()
      .eq('class_code', code);

  // Filter response to get only specific student data, e.g., by student_id
  studentsData = response
      .map(
        (student) => {
          'username': student['username'],
          'height': student['height'],
          'weight': student['weight'],
          'status': student['status'],
          'email': student['email'],
          'segak': student['segak'],
        },
      )
      .toList();
}

/// 🔸 Save updated tasks list to Supabase
Future<void> saveTasks(String code, List<Map<String, dynamic>> tasks) async {
  final safeTasks = tasks.map((t) => t.cast<String, Object?>()).toList();

  await supabase
      .from('classrooms')
      .update({'tasks': safeTasks})
      .eq('code', code);
}

/// 🔸 Update classroom announcement
Future<void> updateAnnouncement(String code, String title) async {
  await supabase.from('classrooms').update({'text': title}).eq('code', code);
  loadClassData(code);
}

/// 🔸 Delete class (teacher only)
Future<void> deleteClass(String code) async {
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception("No logged-in user");

  final response = await supabase
      .from('classrooms')
      .select()
      .eq('code', code)
      .maybeSingle();

  if (response != null && response['teacher_id'] == user.id) {
    await supabase.from('classrooms').delete().eq('code', code);
    await supabase.from('classroom_members').delete().eq('class_code', code);
  } else {
    throw Exception("Only the teacher can delete the class");
  }
}

/// 🔸 Leave class (student only)
Future<void> leaveClass() async {
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception("No logged-in user");

  await supabase.from('classroom_members').delete().eq('student_id', user.id);
  saveUserInfo();
}

/// 🔸 Fetch all students with the same class code
Future<List<String>> getStudentsWithSameCode(String code) async {
  try {
    final List<Map<String, dynamic>> response = await supabase
        .from('classroom_members')
        .select()
        .eq('class_code', code);

    final List<String> usernames = response
        .map((row) => row['name'] as String)
        .toList();

    return usernames;
  } catch (error) {
    return [];
  }
}

/// 🔸  save segak data

Future<void> saveStudentsSegak() async {
  final user = supabase.auth.currentUser;

  if (user == null) return;
  final memberResponse = await supabase
      .from('profiles')
      .select()
      .eq('id', user.id)
      .maybeSingle();

  if (memberResponse != null) {
    await supabase.from('profiles').update({'segak': segak}).eq('id', user.id);
  }
}

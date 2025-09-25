import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:FitVise/Global.dart';

final supabase = Supabase.instance.client;

Future<void> saveUserInfo() async {
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception('No logged-in user');

  await supabase.from('profiles').upsert({
    'id': user.id,
    'email': currentEmail,
    'username': currentUsername, //username
    'height': currentHeight,
    'weight': currentWeight,
    'status': userStatus,
    'is_teacher': isTeacher,
    'is_premium': isPremium,
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
  }
}

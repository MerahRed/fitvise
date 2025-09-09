import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:FitVise/Global.dart';

final supabase = Supabase.instance.client;

Future<void> saveUserInfo() async {
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception('No logged-in user');

  await supabase.from('profiles').upsert({
    'id': user.id,
    'email': currentEmail,
    'username': currentEmail, //username
    'height': currentheight,
    'weight': currentweight,
    'status': user_status,
  });
}

Future<void> loadUserInfo() async {
  final user = supabase.auth.currentUser;
  if (user == null) return;

  final response =
      await supabase.from('profiles').select().eq('id', user.id).maybeSingle();

  if (response != null) {
    currentEmail = response['email'] ?? "";
    username = response['username'] ?? "user";
    currentheight = response['height'];
    currentweight = response['weight'];
    user_status = response['status'] ?? "Normal";
  }
}

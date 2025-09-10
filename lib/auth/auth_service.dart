import 'package:FitVise/Global.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign in
  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    try {
      return await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      throw Exception(e.message); // only show clean message
    } catch (e) {
      throw Exception("Unexpected error, please try again.");
    }
  }

  // Sign up
  Future<AuthResponse> signUpWithEmailPassword(
      String email, String password, String username) async {
    try {
      currentEmail = email;
      currentUsername = username;
      return await _supabase.auth.signUp(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Unexpected error, please try again.");
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    currentEmail = "";
    currentUsername = "user";
    currentheight = 0;
    currentweight = 0;
    user_status = "Normal";
    pageIndex = 3;
    targetKg = 0;
  }

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    return session?.user.email;
  }
}

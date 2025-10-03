/*

AUTH GATE - this continuosly listen for auth state changes.

-------------------------------------------------------------------------------------------

unauthenticated - Login Page
authenticated = Profile Page / Home Page

*/

import 'package:FitVise/Global.dart';
import 'package:FitVise/Pages/bmi.dart';
import 'package:FitVise/auth/loginPage.dart';
import 'package:FitVise/profile_Service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//page
import 'package:FitVise/Pages/health.dart';
import 'package:FitVise/Pages/fitness.dart';
import 'package:FitVise/Pages/profile.dart';
import 'package:FitVise/Pages/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<Widget> _getRedirectPage() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return const Loginpage();

    // Load user info from Supabase
    await loadUserInfo();

    // Check BMI status
    if (currentHeight == 0 || currentWeight == 0) {
      return const Bmipage(); // go to BMI first
    } else {
      final List page = [Homepage(), Fitpage(), Healthpage(), Profilepage()];
      return page[pageIndex]; // normal navigation
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // Loading... (no internet)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          // User logged in  decide BMI / Home
          return FutureBuilder<Widget>(
            future: _getRedirectPage(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              return snapshot.data!;
            },
          );
        } else {
          // User logged out (go to Login)
          return const Loginpage();
        }
      },
    );
  }
}

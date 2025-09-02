/*

AUTH GATE - this continuosly listen for auth state changes.

-------------------------------------------------------------------------------------------

unauthenticated - Login Page
authenticated = Profile Page / Home Page

*/

import 'package:FitVise/Global.dart';
import 'package:FitVise/auth/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//page
import 'package:FitVise/Pages/health.dart';
import 'package:FitVise/Pages/fitness.dart';
import 'package:FitVise/Pages/profile.dart';
import 'package:FitVise/Pages/home.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //Listen to auth state changes 
      stream: Supabase.instance.client.auth.onAuthStateChange,

      //build the appropriate page 
      builder: (context, snapshot) {
        //Loading...
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        //check if there is valid session
        final session = snapshot.hasData ? snapshot.data!.session : null;
        
        final List _page = [Homepage(), Fitpage(), Healthpage(), Profilepage()];

        if (session != null){
          return _page[pageIndex]; //Profile page
        }else{
          return const Loginpage();
        }
      },
    );
  }
}
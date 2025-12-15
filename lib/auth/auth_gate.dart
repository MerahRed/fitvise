import 'package:FitVise/Pages/workouts.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:FitVise/Global.dart';
import 'package:FitVise/auth/login_page.dart';
import 'package:FitVise/Pages/bmi.dart';
import 'package:FitVise/Pages/home.dart';
import 'package:FitVise/Pages/fitness.dart';
import 'package:FitVise/Pages/health.dart';
import 'package:FitVise/Pages/profile.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  List<Widget> pages = [
    Workouts(),
    Healthpage(),
    Homepage(),
    Fitpage(),
    Profilepage(),
  ];

  void changePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (session == null) {
          return const Loginpage();
        }

        // Logged in
        if (currentHeight == 0 || currentWeight == 0) {
          return const Bmipage();
        }

        // Normal app pages + navigation
        return Scaffold(
          body: pages[pageIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageIndex,
            onTap: (i) {
              setState(() {
                pageIndex = i;
              });
            },
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.accessibility_new_rounded),
                label: 'Workouts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Health',
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.home,
                    color: pageIndex == 2 ? Colors.white : Colors.grey.shade400,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                label: 'Fitness',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:FitVise/auth/auth_gate.dart';
import 'package:FitVise/profile_Service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Global.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://jvhwabzhfplqpwuxapbl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp2aHdhYnpoZnBscXB3dXhhcGJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYyODAwNjcsImV4cCI6MjA3MTg1NjA2N30.LCN0oRZeBa_Xo6Z1RXyGfQwTsePlpAXQKBApX-ZxfQU',
  );

  if (Supabase.instance.client.auth.currentUser != null) {
    await loadUserInfo();
  }

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double height = 0;
  double target = 1;

  void updatePage(int page) {
    setState(() {
      pageIndex = page;
      //set the variable to current page index
    });
  }

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await loadUserInfo();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.greenAccent[400],
          unselectedItemColor: Colors.grey[400],
          elevation: 100,
        ),
      ),
      home: Scaffold(
        //set current page
        body: AuthGate(), //_page[pageIndex],

        bottomNavigationBar: BottomNavigationBar(
          onTap: (page) {
            updatePage(page);
          },
          currentIndex: pageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Fitness',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Health',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

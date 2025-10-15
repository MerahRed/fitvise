import 'package:FitVise/auth/auth_gate.dart';
import 'package:FitVise/Global.dart';
import 'package:FitVise/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jvhwabzhfplqpwuxapbl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp2aHdhYnpoZnBscXB3dXhhcGJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYyODAwNjcsImV4cCI6MjA3MTg1NjA2N30.LCN0oRZeBa_Xo6Z1RXyGfQwTsePlpAXQKBApX-ZxfQU',
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int pageIndex = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    if (Supabase.instance.client.auth.currentUser != null) {
      await loadUserInfo();
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: AnimatedSplashScreen(
        splash: "assets/GIF FitVise/Splash screen.gif",
        nextScreen: AuthGate(),
        duration: 4000,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
      ),
    );
  }
}

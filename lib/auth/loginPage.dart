import 'package:FitVise/auth/auth_service.dart';
import 'package:FitVise/auth/registerPage.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  //get auth service
  final authService = AuthService();

  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //login button pressed
void login() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();

  try {
    await authService.signInWithEmailPassword(email, password);
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 250, horizontal: 30),
        children: [
          //email
          TextField(
            decoration: InputDecoration(labelText: "Email"),
            controller: _emailController,
          ),
          //password
          TextField(
            decoration: InputDecoration(labelText: "Password"),
            controller: _passwordController,
          ),
          //login
          ElevatedButton(
            onPressed: login,
            child: const Text('Login'),
          ),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  ),
              child: Center(child: Text("Don't have an account? Sign Up")))
        ],
      ),
    );
  }
}

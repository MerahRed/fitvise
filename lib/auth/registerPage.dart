import 'package:FitVise/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //get auth service
  final authService = AuthService();

  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPaswordController = TextEditingController();

  //Sign Up
void signUp() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();
  final confirmPassword = _confirmPaswordController.text.trim();

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Passwords don't match")),
    );
    return;
  }

  try {
    await authService.signUpWithEmailPassword(email, password);
    Navigator.pop(context); // back to login
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
          TextField(
            controller: _confirmPaswordController,
            decoration: InputDecoration(labelText: "Confirm Password"),
          ),
          //SignUp
          ElevatedButton(
            onPressed: signUp,
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}

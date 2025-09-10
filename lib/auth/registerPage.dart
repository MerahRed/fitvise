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
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPaswordController = TextEditingController();

  //Sign Up
  void signUp() async {
    final username = _usernameController.text.trim();
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
      await authService.signUpWithEmailPassword(email, password, username);
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome to ",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  "FitVise",
                  style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 50),
            Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(labelText: "Username"),
              controller: _usernameController,
            ),
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: signUp,
              child: const Text('Sign Up'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

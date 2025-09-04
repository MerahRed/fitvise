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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Greetings
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome back to ",
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
                "Log In",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              SizedBox(height: 30),
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
              SizedBox(height: 10),
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
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.greenAccent,
                            decoration: TextDecoration.underline),
                      )
                    ],
                  )))
            ],
          ),
        ),
      ),
    );
  }
}

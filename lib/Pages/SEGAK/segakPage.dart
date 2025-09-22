import 'package:FitVise/Pages/SEGAK/pushup.dart';
import 'package:FitVise/Pages/SEGAK/sitandreach.dart';
import 'package:FitVise/main.dart';
import 'package:flutter/material.dart';

class Segakpage extends StatelessWidget {
  const Segakpage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainApp()),
                  (_) => false,
                );
              },
            ),
            title: Text(
              "SEGAK",
              style: TextStyle(fontWeight: FontWeight.bold),
            ), // Display exercise name
            centerTitle: true,
            backgroundColor: Colors.black87,
          ),
          body: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/assets/bear.gif",
                      scale: 3,
                    ),
                    Text(
                      "Start measuring your body health",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => PushupPage()),
                          (_) => false,
                        ); // should be pushupPage()
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade400,
                              Colors.green.shade700
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 32),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ))),
    );
  }
}

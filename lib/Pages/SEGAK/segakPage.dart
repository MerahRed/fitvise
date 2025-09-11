import 'package:FitVise/Pages/SEGAK/pushup.dart';
import 'package:FitVise/Pages/SEGAK/step_test.dart';
import 'package:FitVise/Pages/fitness.dart';
import 'package:FitVise/main.dart';
import 'package:flutter/material.dart';

class Segakpage extends StatelessWidget {
  const Segakpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MainApp())); // should be pushupPage()
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PushupPage())); // should be pushupPage()
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green[300]),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Continue',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )));
  }
}

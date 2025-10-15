import 'package:FitVise/Pages/SEGAK/pushup.dart';
import 'package:FitVise/Pages/SEGAK/resultPage.dart';
import 'package:FitVise/Pages/SEGAK/step_test.dart';
import 'package:FitVise/auth/auth_gate.dart';
import 'package:FitVise/main.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';

class Sitandreach extends StatefulWidget {
  const Sitandreach({super.key});

  @override
  State<Sitandreach> createState() => _sitandreachState();
}

class _sitandreachState extends State<Sitandreach> {
  String overall = "Well Done";
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Sit and Reach",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.black87,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => AuthGate()),
                (_) => false,
              );
            },
          ),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/GIF FitVise/Jangkauan Melunjur.gif",
                            scale: 2.5,
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            "Sit and Reach Guideline",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 32,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const Divider(
                            height: 32,
                            thickness: 2,
                            indent: 30,
                            endIndent: 30,
                          ),
                          Text("""
      Procedure:
      
      1. Student sits on the floor with legs straight, feet together, and soles upright.
      2. Arms extended forward, try to reach the toes.
      3. Record the furthest point reached.
      
      Suggested Scoring Scale:
      
      - 5 points: Fingers pass beyond the toes (reaching the feet or further).
      - 4 points: Fingers exactly reach the tips of the toes.
      - 3 points: Fingers slightly short (around the ankles).
      - 2 points: Fingers only reach the middle of the shins.
      - 1 point: Fingers only reach around the knees.
      """, style: TextStyle(color: Colors.black, fontSize: 20)),
                          const Text(
                            "Enter Your Score",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const Divider(
                            height: 32,
                            thickness: 2,
                            indent: 30,
                            endIndent: 30,
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: TextField(
                              controller: _controller,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                labelText: "Enter number 1 - 5",
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        if (_controller.text == "1" ||
                            _controller.text == "2" ||
                            _controller.text == "3" ||
                            _controller.text == "4" ||
                            _controller.text == "5") {
                          segak["Sit and Reach"] = int.parse(_controller.text);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => steptestPage(),
                            ),
                            (_) => false,
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade400,
                              Colors.green.shade700,
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
                            vertical: 14.0,
                            horizontal: 32,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 28,
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Next",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

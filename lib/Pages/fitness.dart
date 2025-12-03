import 'package:FitVise/Pages/SEGAK/segak_page.dart';
import 'package:FitVise/Pages/bmi.dart';
import 'package:FitVise/utilities/text_card.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';
import 'package:FitVise/utilities/icon_card.dart';

class Fitpage extends StatefulWidget {
  const Fitpage({super.key});

  @override
  State<Fitpage> createState() => _FitpageState();
}

class _FitpageState extends State<Fitpage> {
  @override
  Widget build(BuildContext context) {
    //get screen size
    double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: ListView(
          children: [
            // ---------------- Today's Exercise ----------------
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.grey.shade900],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Exercise",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      const Divider(color: Colors.white10),
                      itemCard(
                        cardIcon: exercise[exerciseIndex][0][4],
                        title: exercise[exerciseIndex][0][0],
                        description: exercise[exerciseIndex][0][1],
                        cardColor: Colors.blue,
                        exerciseImage: exercise[exerciseIndex][0][2],
                        details: exercise[exerciseIndex][0][3],
                      ),
                      itemCard(
                        cardIcon: exercise[exerciseIndex][1][4],
                        title: exercise[exerciseIndex][1][0],
                        description: exercise[exerciseIndex][1][1],
                        cardColor: Colors.blue,
                        exerciseImage: exercise[exerciseIndex][1][2],
                        details: exercise[exerciseIndex][1][3],
                      ),
                      itemCard(
                        cardIcon: exercise[exerciseIndex][2][4],
                        title: exercise[exerciseIndex][2][0],
                        description: exercise[exerciseIndex][2][1],
                        cardColor: Colors.blue,
                        exerciseImage: exercise[exerciseIndex][2][2],
                        details: exercise[exerciseIndex][2][3],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ---------------- Text Card ----------------
            Padding(
              padding: EdgeInsets.all(20),
              child: Textcard(
                title: "Lets Improve our physical body!",
                description: "Start your fitness journey now",
                startColor: Colors.blueAccent,
                endColor: Colors.black12,
              ),
            ),

            // ---------------- SEGAK & BMI ----------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SEGAK
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 20,
                        right: 10,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Segakpage(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 12,
                                offset: Offset(3, 6),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade900,
                                Colors.green.shade300,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.data_saver_off_rounded,
                                        size: screenWidth * 0.08,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Measure",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "SEGAK",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.07,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // BMI
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 10,
                        right: 20,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Bmipage(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 12,
                                offset: Offset(3, 6),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade700,
                                Colors.grey.shade300,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.calculate,
                                        size: screenWidth * 0.08,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Calculate",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "BMI",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.07,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
    );
  }
}

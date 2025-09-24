import 'package:FitVise/Pages/SEGAK/segakPage.dart';
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: ListView(
          children: [
            //                    Today's Exercise
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
                          fontSize: 40,
                        ),
                      ),
                      Divider(
                        color: Colors.white10,
                      ),
                      itemCard(
                        cardIcon: 'lib/assets/fitness.png',
                        title: exercise[exerciseIndex][0][0],
                        description: exercise[exerciseIndex][0][1],
                        cardColor: Colors.blue,
                        exerciseImage: exercise[exerciseIndex][0][2],
                        details: exercise[exerciseIndex][0][3],
                      ),
                      itemCard(
                        cardIcon: 'lib/assets/fitness.png',
                        title: exercise[exerciseIndex][1][0],
                        description: exercise[exerciseIndex][1][1],
                        cardColor: Colors.blue,
                        exerciseImage: exercise[exerciseIndex][1][2],
                        details: exercise[exerciseIndex][1][3],
                      ),
                      itemCard(
                        cardIcon: 'lib/assets/fitness.png',
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
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Textcard(
                title: "Lets Improve our physical body!",
                description: "Start your fitness journey now",
                startColor: Colors.blueAccent,
                endColor: Colors.black12,
              ),
            ),

            //                    SEGAK
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20, right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Segakpage()),
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [Colors.black12, Colors.green.shade700],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.data_saver_off_rounded,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Measure your Health via"),
                                  Text(
                                    "SEGAK",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'lib/assets/Segak.png',
                                scale: 5,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //                       BMI
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 10, right: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Bmipage()),
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [Colors.black12, Colors.grey],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.monitor_weight_outlined,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Check your BMI with"),
                                  Text(
                                    "BMI Calculator",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.calculate_rounded,
                                size: 100,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

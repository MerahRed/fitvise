import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';
import 'package:FitVise/utilities/iconCard.dart';

class Fitpage extends StatelessWidget {
  const Fitpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          /*Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black87,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.accessibility_rounded,
                        color: Colors.greenAccent, size: 200),
                    Divider(
                      color: Colors.white10,
                    ),
                  ],
                ),
              ),
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black87,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Exercise",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
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
        ],
      ),
    );
  }
}

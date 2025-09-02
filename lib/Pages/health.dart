import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';
import 'package:FitVise/utilities/iconCard.dart';

class Healthpage extends StatelessWidget {
  const Healthpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
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
                    Text("Calories Needed",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                    Text(
                        (kcal[kcalIndex][0] +
                                kcal[kcalIndex][1] +
                                kcal[kcalIndex][2] +
                                kcal[kcalIndex][3])
                            .toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Today's Diet",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      color: Colors.white10,
                    ),
                    itemCard(
                      cardIcon: 'lib/assets/croissant.png',
                      title: 'Breakfast',
                      description: kcal[kcalIndex][0].toString() + ' kcal',
                      cardColor: Colors.yellow[800],
                      exerciseImage: 'lib/assets/breakfastPic.jpeg',
                      details:
                          'Breakfast is the first meal of the day. It is important to have a balanced meal that includes protein, fiber, and healthy fats.',
                    ),
                    itemCard(
                        cardIcon: 'lib/assets/apple.png',
                        title: 'Snack',
                        description: kcal[kcalIndex][1].toString() + ' kcal',
                        cardColor: Colors.red[900],
                        exerciseImage: 'lib/assets/snackPic.jpeg',
                        details:
                            'Snacks are small meals that can help keep your energy levels up throughout the day. They should be healthy and balanced, including protein, fiber, and healthy fats.'),
                    itemCard(
                        cardIcon: 'lib/assets/dish.png',
                        title: 'Lunch',
                        description: kcal[kcalIndex][2].toString() + ' kcal',
                        cardColor: Colors.green[700],
                        exerciseImage: 'lib/assets/lunchPic.jpeg',
                        details:
                            'Lunch is the meal eaten in the middle of the day. It is important to have a balanced meal that includes protein, vegetables, and healthy fats.'),
                    itemCard(
                      cardIcon: 'lib/assets/dinner.png',
                      title: 'Dinner',
                      description: kcal[kcalIndex][3].toString() + ' kcal',
                      cardColor: Colors.blue[900],
                      exerciseImage: 'lib/assets/dinnerPic.jpeg',
                      details:
                          'Dinner is the last meal of the day. It is important to have a balanced meal that includes protein, vegetables, and healthy fats.',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black87,
                        gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade700,
                              Colors.lightBlueAccent.shade200
                            ],
                            begin: Alignment.center,
                            end: Alignment.bottomRight)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.apple, size: 50),
                          Text('Food Pyramid'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black87,
                        gradient: LinearGradient(
                            colors: [Colors.teal, Colors.tealAccent.shade400],
                            begin: Alignment.center,
                            end: Alignment.bottomRight)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.search, size: 50),
                          Text('Disease Finder'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

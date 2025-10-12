import 'package:FitVise/Pages/Classroom/classMenu.dart';
import 'package:FitVise/Pages/Classroom/classroom_page.dart';
import 'package:FitVise/Pages/chat_page.dart';
import 'package:FitVise/utilities/premium_popup.dart';
import 'package:FitVise/utilities/text_card.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';
import 'package:FitVise/utilities/icon_card.dart';

class Healthpage extends StatelessWidget {
  const Healthpage({super.key});

  @override
  Widget build(BuildContext context) {
    // get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Calorie Needed 🥗',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${kcal[kcalIndex][0] + kcal[kcalIndex][1] + kcal[kcalIndex][2] + kcal[kcalIndex][3]} Kcal',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.grey.shade900],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Today's Diet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    color: Colors.white10,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  itemCard(
                    cardIcon: 'lib/assets/croissant.png',
                    title: 'Breakfast',
                    description: '${kcal[kcalIndex][0]} kcal',
                    cardColor: Colors.yellow[800],
                    exerciseImage: 'lib/assets/breakfastPic.jpeg',
                    details:
                        'Breakfast is the first meal of the day. It is important to have a balanced meal that includes protein, fiber, and healthy fats.',
                  ),
                  itemCard(
                    cardIcon: 'lib/assets/apple.png',
                    title: 'Snack',
                    description: '${kcal[kcalIndex][1]} kcal',
                    cardColor: Colors.red[900],
                    exerciseImage: 'lib/assets/snackPic.jpeg',
                    details:
                        'Snacks are small meals that can help keep your energy levels up throughout the day. They should be healthy and balanced, including protein, fiber, and healthy fats.',
                  ),
                  itemCard(
                    cardIcon: 'lib/assets/dish.png',
                    title: 'Lunch',
                    description: '${kcal[kcalIndex][2]} kcal',
                    cardColor: Colors.green[700],
                    exerciseImage: 'lib/assets/lunchPic.jpeg',
                    details:
                        'Lunch is the meal eaten in the middle of the day. It is important to have a balanced meal that includes protein, vegetables, and healthy fats.',
                  ),
                  itemCard(
                    cardIcon: 'lib/assets/dinner.png',
                    title: 'Dinner',
                    description: '${kcal[kcalIndex][3]} kcal',
                    cardColor: Colors.blue[900],
                    exerciseImage: 'lib/assets/dinnerPic.jpeg',
                    details:
                        'Dinner is the last meal of the day. It is important to have a balanced meal that includes protein, vegetables, and healthy fats.',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Textcard(
              title: "Discover More With FitVise",
              description:
                  "With FitVise, health diet become easier and simpler.",
              startColor: Colors.deepOrangeAccent,
              endColor: Colors.black12,
            ),
          ),
          Row(
            // row
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //        ------------------ Class --------------------
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
                          builder: (context) => (classCode.isNotEmpty)
                              ? ClassroomPage(code: classCode)
                              : Classmenu(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 12,
                            offset: const Offset(3, 6),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade900, Colors.blue.shade100],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.school_rounded,
                                  size: screenWidth * 0.08,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Join",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                  ),
                                ),
                                Text(
                                  "Class",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.07,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //      --------------------- Health Tips ---------------------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 10,
                    right: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (isPremium == false) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              insetPadding: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const PremiumPopup(),
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FitViseChatPage(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 12,
                            offset: const Offset(3, 6),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade900,
                            Colors.purple.shade100,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.tips_and_updates_rounded,
                                  size: screenWidth * 0.08,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Ask our",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                  ),
                                ),
                                Text(
                                  "ChatBot",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.07,
                                  ),
                                ),
                              ],
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
        ],
      ),
    );
  }
}

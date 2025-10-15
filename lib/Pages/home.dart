// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:FitVise/auth/auth_gate.dart';
import 'package:FitVise/profile_Service.dart';
import 'package:FitVise/utilities/text_card.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';
import 'package:FitVise/main.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //var
  String dateFormat = DateFormat('dd-MM-yyyy hh:mm').format(date);

  void updatePage(int page) {
    setState(() {
      pageIndex = page;
      //set the variable to current page index
    });
  }

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
    calculateTarget();
  }

  Future<void> loadData() async {
    await loadUserInfo();
    setState(() {
      loading = false;
    });
  }

  Future<void> calculateTarget() async {
    double bmiTarget = 0;

    if (currentHeight != null && currentWeight != null) {
      if (currentHeight != null &&
          currentWeight != null &&
          currentHeight! > 0 &&
          currentWeight! > 0) {
        double heightInMeters = currentHeight! / 100;
        double heightSquared = heightInMeters * heightInMeters;
        double result = currentWeight! / heightSquared;

        if (result < 18.5) {
          bmiTarget = 18.6;
        }
        if (result > 25) {
          bmiTarget = 24.9;
        }
        double target = heightSquared * bmiTarget;
        targetKg = target.round();
      }
    }
  }

  // 0- underweight, 1- normal, 2- overweight, 3- obesity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FitVise",
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // SizedBox(height: 130),

          //                 - G R E E T I N G -
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              //             - EDIT / DIALOG ALERT -
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          //SizedBox(width: 10),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white30,
                            child: Icon(Icons.person, size: 50),
                          ),
                          SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, ' + currentUsername + ' 👋',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(width: 30),
                              Text(
                                DateFormat.yMMMMd().format(date),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //                       Data
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statBox(Icons.accessibility, "$currentWeight kg", "Weight"),
              _statBox(Icons.height, "$currentHeight cm", "Height"),
              _statBox(Icons.healing, userStatus, "BMI"),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      userStatus != 'Normal'
                          ? "🎯 Target Weight"
                          : "👏 Keep it up!",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userStatus != 'Normal'
                          ? "$targetKg Kg"
                          : "You're on track!",
                      style: TextStyle(
                        fontSize: userStatus != 'Normal' ? 40 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //                   DIET
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 2; // Go to "Health" page
                });
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthGate()),
                  (_) => false,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white12.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.indigo.shade600, Colors.blueAccent],
                    begin: Alignment.center,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.restaurant_menu_rounded, size: 40),
                            const SizedBox(height: 10),
                            Text(
                              "Today's \nDiet",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              DateFormat.EEEE().format(date),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'lib/assets/dish.png',
                        scale: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //                   EXERCISE
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 1; // Go to "Health" page
                });
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AuthGate()),
                  (_) => false,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(3, 6),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.tealAccent.shade400],
                    begin: Alignment.center,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.fitness_center_rounded, size: 40),
                            const SizedBox(height: 10),
                            Text(
                              "Today's \nExercises",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              DateFormat.EEEE().format(date),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'lib/assets/exercise.png',
                        scale: 5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _statBox(IconData icon, String value, String label) {
  return Column(
    children: [
      Icon(icon, size: 28, color: Colors.tealAccent),
      const SizedBox(height: 6),
      Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
    ],
  );
}

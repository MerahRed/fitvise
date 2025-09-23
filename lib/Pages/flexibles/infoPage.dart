import 'package:FitVise/main.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';

class InfoPage extends StatefulWidget {
  final String exerciseName;
  final String exerciseImage;
  final String exerciseDescription;
  final bool isDiet;
  const InfoPage({
    super.key,
    required this.exerciseName,
    required this.exerciseImage,
    required this.exerciseDescription,
    required this.isDiet,
  });

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     widget.exerciseName,
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ), // Display exercise name
      //   centerTitle: true,
      //   backgroundColor: Colors.black87,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (widget.exerciseImage.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          widget.exerciseImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.exerciseName,
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainApp()),
                              (_) => false,
                            );
                          },
                          icon: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.close_outlined,
                              color: Colors.black87,
                              size: 25,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    Text(widget.exerciseDescription,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    SizedBox(height: 20),
                    widget.isDiet == true // check if it's diet page
                        ? Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Target Kcal",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  //              WELCOME TO SPAGGHETTI CODE HELL  >:) (forgive me my future self;-;)
                                  userStatus == 'Underweight'
                                      ? widget.exerciseName == 'Breakfast'
                                          ? "700"
                                          : widget.exerciseName == 'Snack'
                                              ? "500"
                                              : widget.exerciseName == 'Lunch'
                                                  ? "800"
                                                  : widget.exerciseName ==
                                                          'Dinner'
                                                      ? "800"
                                                      : "null"
                                      : userStatus == 'Normal'
                                          ? widget.exerciseName == 'Breakfast'
                                              ? "500"
                                              : widget.exerciseName == 'Snack'
                                                  ? "400"
                                                  : widget.exerciseName ==
                                                          'Lunch'
                                                      ? "600"
                                                      : widget.exerciseName ==
                                                              'Dinner'
                                                          ? "600"
                                                          : "null"
                                          : userStatus == 'Overweight'
                                              ? widget.exerciseName ==
                                                      'Breakfast'
                                                  ? "400"
                                                  : widget.exerciseName ==
                                                          'Snack'
                                                      ? "300"
                                                      : widget.exerciseName ==
                                                              'Lunch'
                                                          ? "600"
                                                          : widget.exerciseName ==
                                                                  'Dinner'
                                                              ? "450"
                                                              : "null"
                                              : userStatus == 'Obesity'
                                                  ? widget.exerciseName ==
                                                          'Breakfast'
                                                      ? "300"
                                                      : widget.exerciseName ==
                                                              'Snack'
                                                          ? "150"
                                                          : widget.exerciseName ==
                                                                  'Lunch'
                                                              ? "500"
                                                              : widget.exerciseName ==
                                                                      'Dinner'
                                                                  ? "400"
                                                                  : "null"
                                                  : "null",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(height: 20),
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


/*
          MaterialButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoPage(
                          exerciseName: "s",
                          exerciseImage: 'lib/assets/walking.jpeg',
                          exerciseDescription: 'exerciseDescription',
                          isDiet: false,
                        )),
              );
            },
            color: Colors.green,
            child: Text('Edit'),
          ),

*/
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:FitVise/Pages/SEGAK/segakPage.dart';
import 'package:flutter/material.dart';
import 'package:FitVise/Global.dart';
import 'package:FitVise/main.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //var
  String dateFormat = DateFormat('dd-MM-yyyy hh:mm').format(date);

  // 0- underweight, 1- normal, 2- overweight, 3- obesity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // SizedBox(height: 130),

          //                 - G R E E T I N G -
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              //             - EDIT / DIALOG ALERT -
              child: Container(
                height: 80,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.black12],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          //SizedBox(width: 10),
                          Icon(Icons.person, size: 50),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text('Hello, ' + username + '!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ]),
                              Row(children: [
                                //status
                                Icon(Icons.healing,
                                    size: 15, color: Colors.grey),
                                Text('$user_status •',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                                //weight
                                Icon(Icons.accessibility,
                                    size: 15, color: Colors.grey),
                                Text('$currentweight Kg •',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                                //height
                                Icon(Icons.height_rounded,
                                    size: 15, color: Colors.grey),
                                Text('$currentheight m  ',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                              ])
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

          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black12, Colors.black38],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        user_status != 'Normal'
                            ? 'Target Weight'
                            : 'Congratulations for your current body!',
                      ),
                      Text(
                        user_status != 'Normal'
                            ? '$targetKg Kg'
                            : 'Keep it up!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: user_status != 'Normal' ? 60 : 40),
                      )
                    ],
                  )),
            ),
          ),



          //                    EXCERCISE
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 1;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainApp()),
                  );
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.teal, Colors.tealAccent.shade400],
                        begin: Alignment.center,
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
                            Icons.today,
                            size: 40,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Today's Exercises"),
                          Text(
                            DateFormat.EEEE().format(date),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ],
                      ),
                      Image.asset(
                        'lib/assets/exercise.png',
                        scale: 4,
                        color: Colors.white,
                      )
                    ],
                  ),
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
                  pageIndex = 2;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainApp()),
                  );
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.indigo.shade600, Colors.blueAccent],
                        begin: Alignment.center,
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
                            Icons.today,
                            size: 40,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Today's Diet"),
                          Text(
                            DateFormat.EEEE().format(date),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ],
                      ),
                      Image.asset(
                        'lib/assets/dish.png',
                        scale: 5,
                        color: Colors.white,
                      )
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

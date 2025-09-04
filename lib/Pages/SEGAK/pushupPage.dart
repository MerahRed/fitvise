import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class pushupPage extends StatefulWidget {
  // final String exerciseName;
  // final String exerciseImage;
  // final String exerciseDescription;
  // final bool isDiet;
  // const InfoPage({
  //   super.key,
  //   required this.exerciseName,
  //   required this.exerciseImage,
  //   required this.exerciseDescription,
  //   required this.isDiet,
  // });

  @override
  State<pushupPage> createState() => _pushupPageState();
}

class _pushupPageState extends State<pushupPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Push Up",
          style: TextStyle(fontWeight: FontWeight.bold),
        ), // Display exercise name
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  "lib/assets/bear.gif",
                  scale: 3,
                ),
                Text(
                  "Push Up",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                TimerCountdown(
                  format: CountDownTimerFormat.secondsOnly,
                  endTime: DateTime.now().add(
                    Duration(
                      seconds: 60,
                    ),
                  ),
                  timeTextStyle: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  onEnd: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Text("How many push up have you done?"),
                                      TextField(),
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Confirm"),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ));
                  },
                ),
              ],
            ),
          )),
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
import 'package:FitVise/Pages/SEGAK/situp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:FitVise/Global.dart';

class pushupPage extends StatefulWidget {
  const pushupPage({super.key});

  @override
  State<pushupPage> createState() => _pushupPageState();
}

class _pushupPageState extends State<pushupPage> {
  final _controller = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.center,
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
                      seconds: 1,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "How many push up have you done?",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 20),
                                      TextField(
                                        controller: _controller,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            labelText: "Enter number",
                                            border: OutlineInputBorder()),
                                      ),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            segak["Push up"] = _controller.text;
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SitupPage(),
                                              ),
                                            );
                                          });
                                        },
                                        child: Text("Confirm"),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ));
                  },
                ),
                SizedBox(height: 50),
              ],
            ),
          )),
    );
  }
}

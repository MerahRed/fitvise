import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:FitVise/Global.dart';

class SitupPage extends StatefulWidget {
  const SitupPage({super.key});

  @override
  State<SitupPage> createState() => _SitupPageState();
}

class _SitupPageState extends State<SitupPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Sit Up",
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
                  "lib/assets/SIT_UP.gif",
                  scale: 3,
                ),
                Text(
                  "Sit Up",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                TimerCountdown(
                  format: CountDownTimerFormat.secondsOnly,
                  endTime: DateTime.now().add(
                    Duration(
                      seconds: 5,
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
                                        "How many sit up have you done?",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 50),
                                      TextField(
                                        controller: _controller,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            labelText: "Enter number",
                                            border: OutlineInputBorder()),
                                      ),
                                      SizedBox(height: 50),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            segak["Sit up"] = _controller.text;
                                            Navigator.pop(context);
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
                Text(segak.toString()),
              ],
            ),
          )),
    );
  }
}

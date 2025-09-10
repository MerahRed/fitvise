import 'package:FitVise/Pages/SEGAK/pushup.dart';
import 'package:FitVise/Pages/SEGAK/situp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:FitVise/Global.dart';
import 'package:flutter_tts/flutter_tts.dart'; // 👈 Import TTS

class SitupPage extends StatefulWidget {
  const SitupPage({super.key});

  @override
  State<SitupPage> createState() => _SitupPageState();
}

class _SitupPageState extends State<SitupPage> {
  final _controller = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();

  bool _exerciseStarted = false;
  String _countdownText = "Get ready..."; // 👈 Show countdown text

  @override
  void initState() {
    super.initState();
    _setupTts();
    _startVoiceCountdown();
  }

  Future<void> _setupTts() async {
    await flutterTts.setSpeechRate(0.4); // slower
    await flutterTts.setPitch(1.0);
  }

  Future<void> _startVoiceCountdown() async {
    setState(() {
      _countdownText = "Get ready for sit up...";
    });
    await flutterTts.speak("Get ready for... sit up in...");
    await Future.delayed(const Duration(seconds: 3));

    // Countdown 3 → 2 → 1
    for (int i = 3; i > 0; i--) {
      setState(() {
        _countdownText = i.toString();
      });
      await flutterTts.speak(i.toString());
      await Future.delayed(const Duration(seconds: 1));
    }

    // Start!
    setState(() {
      _countdownText = "Start!";
    });
    await flutterTts.speak("Start!");

    // Show the timer
    setState(() {
      _exerciseStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Sit Up",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/assets/bear.gif", scale: 3),
              const SizedBox(height: 10),
              const Text(
                "Sit Up",
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),

              const SizedBox(height: 30),

              // 👇 Show countdown text until exercise starts
              if (!_exerciseStarted)
                Text(
                  _countdownText,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

              // 👇 After countdown, show 60-sec timer
              if (_exerciseStarted)
                TimerCountdown(
                  format: CountDownTimerFormat.secondsOnly,
                  endTime: DateTime.now().add(
                    const Duration(seconds: 60),
                  ),
                  timeTextStyle: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  onEnd: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "How many sit up have you done?",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: _controller,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Enter number",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      segak["Sit up"] = _controller.text;
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PushupPage(),
                                        ),
                                      );
                                    });
                                  },
                                  child: const Text("Confirm"),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

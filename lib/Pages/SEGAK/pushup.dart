import 'package:FitVise/Pages/SEGAK/situp.dart';
import 'package:FitVise/auth/auth_gate.dart';
import 'package:FitVise/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:FitVise/Global.dart';
import 'package:flutter_tts/flutter_tts.dart'; // 👈 Import TTS
import 'package:audioplayers/audioplayers.dart'; // 👈 Import audioplayers

class PushupPage extends StatefulWidget {
  const PushupPage({super.key});

  @override
  State<PushupPage> createState() => _PushupPageState();
}

class _PushupPageState extends State<PushupPage> {
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

  final AudioPlayer audioPlayer = AudioPlayer();

  Future play() async {
    await audioPlayer.play(AssetSource("assets/sounds/segakMusic.mp3"));
  }

  @override
  void dispose() {
    flutterTts.stop();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _setupTts() async {
    await flutterTts.setSpeechRate(0.4); // slower
    await flutterTts.setPitch(1.0);
    flutterTts.setIosAudioCategory(IosTextToSpeechAudioCategory.ambient, [
      IosTextToSpeechAudioCategoryOptions.mixWithOthers,
    ]);
    flutterTts.setVolume(15);
  }

  Future<void> _startVoiceCountdown() async {
    if (!mounted) return; // Check if the widget is still mounted (running)
    setState(() {
      _countdownText = "Get ready for push up...";
    });
    await flutterTts.speak("Get ready for... push up in...");
    await Future.delayed(const Duration(seconds: 3));

    // Countdown 3 → 2 → 1
    for (int i = 3; i > 0; i--) {
      if (!mounted) return;
      setState(() {
        _countdownText = i.toString();
      });
      await flutterTts.speak(i.toString());
      await Future.delayed(const Duration(seconds: 1));
    }

    // Start!
    if (!mounted) return;
    setState(() {
      _countdownText = "Start!";
    });
    await flutterTts.speak("Start!");
    //await play();

    // Show the timer
    setState(() {
      _exerciseStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Push Up",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AuthGate()),
                (_) => false,
              );
            },
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
                Image.asset("assets/GIF FitVise/Push Up.gif", scale: 2),
                const SizedBox(height: 10),
                const Text(
                  "Push Up",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),

                const SizedBox(height: 30),

                // Show countdown
                if (!_exerciseStarted)
                  Text(
                    _countdownText,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                // After countdown
                if (_exerciseStarted)
                  TimerCountdown(
                    format: CountDownTimerFormat.secondsOnly,
                    endTime: DateTime.now().add(
                      Duration(seconds: isPremium ? 5 : 60),

                      /// EDIT DURATION HERE ///
                    ),
                    timeTextStyle: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    onEnd: () {
                      flutterTts.speak("How many push up have you done?");
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Prevent closing by tapping outside
                        builder: (context) => AlertDialog(
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "How many push up have you done?",
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
                                      if (_controller.text.isNotEmpty) {
                                        setState(() {
                                          segak["Push up"] = _controller.text;
                                          Navigator.pop(context);
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SitupPage(),
                                            ),
                                            (_) => false,
                                          );
                                        });
                                      }
                                    },
                                    child: const Text("Confirm"),
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}

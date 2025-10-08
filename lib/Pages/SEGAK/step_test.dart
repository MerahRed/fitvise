import 'package:FitVise/Pages/SEGAK/pushup.dart';
import 'package:FitVise/Pages/SEGAK/resultPage.dart';
import 'package:FitVise/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:FitVise/Global.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

class steptestPage extends StatefulWidget {
  const steptestPage({super.key});

  @override
  State<steptestPage> createState() => _steptestPageState();
}

class _steptestPageState extends State<steptestPage> {
  final _controller = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer audioPlayer = AudioPlayer();

  bool _exerciseStarted = false;
  String _countdownText = "Get ready..."; //Show countdown text

  @override
  void initState() {
    super.initState();
    _setupTts();
    _startVoiceCountdown();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    flutterTts.stop();
    _controller.dispose();
    super.dispose();
  }

  Future play() async {
    await audioPlayer.play(AssetSource("sounds/metronome.mp3"));
  }

  Future<void> _setupTts() async {
    await flutterTts.setSpeechRate(0.4); // slower
    await flutterTts.setPitch(1.0);
  }

  Future<void> _startVoiceCountdown() async {
    if (!mounted) return;
    setState(() {
      _countdownText = "Get ready for step test...";
    });
    await flutterTts.speak("Get ready for... step test in...");
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
    await play();

    // Show the timer
    if (!mounted) return;
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
          "Step Test",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainApp()),
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
              Image.asset("assets/GIF FitVise/Naik Turun Bangku.gif", scale: 2),
              const SizedBox(height: 10),
              const Text(
                "Step Test",
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

              // After countdown, show 60-sec timer
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
                    audioPlayer.stop();
                    flutterTts.speak("calculate your pulse rate");
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Insert your pulse rate",
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
                                      audioPlayer.stop();
                                      setState(() {
                                        segak["Step test"] = _controller.text;
                                        Navigator.pop(context);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Resultpage(),
                                          ),
                                          (_) => false,
                                        );
                                      });
                                    }
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
            ],
          ),
        ),
      ),
    );
  }
}

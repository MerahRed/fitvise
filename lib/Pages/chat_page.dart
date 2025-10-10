import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class FitViseChatPage extends StatefulWidget {
  const FitViseChatPage({super.key});

  @override
  State<FitViseChatPage> createState() => _FitViseChatPageState();
}

class _FitViseChatPageState extends State<FitViseChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final Random _random = Random();

  // 🔹 Hint system
  final List<String> _hintTexts = [
    "Say something...",
    "Ask me about workouts 💪",
    "Need motivation? Try asking me for one!",
    "Ask about SEGAK test tips 🏃",
    "Want a quick diet tip?",
    "Curious about recovery?",
    "How can I assist you today?",
    "Looking for workout ideas?",
    "Need help with nutrition?",
    "Ask me about fitness goals!",
    "Hmmm... who made me?",
    "Feeling bored? Ask me for a joke!",
  ];
  int _currentHintIndex = 0;
  Timer? _hintTimer;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();

    // 🔁 Rotate hints automatically
    _hintTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_isTyping) {
        setState(() {
          _currentHintIndex = (_currentHintIndex + 1) % _hintTexts.length;
        });
      }
    });

    _controller.addListener(() {
      setState(() {
        _isTyping = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  String _getResponse(String input) {
    input = input.toLowerCase().trim();

    bool _contains(String input, List<String> keywords) {
      for (var word in keywords) {
        final pattern = RegExp(
          r'\b' + RegExp.escape(word) + r'(s|es|ing|ed)?\b',
          caseSensitive: false,
        );
        if (pattern.hasMatch(input)) return true;
      }
      return false;
    }

    // Common keyword groups
    final greetings = [
      'hi',
      'hello',
      'hey',
      'yo',
      'wassup',
      'whats up',
      'what\'s up',
      'sup'
    ];
    final workouts = [
      'workout',
      'exercise',
      'train',
      'training',
      'routine',
      'movement'
    ];
    final diet = ['diet', 'nutrition', 'meal', 'food', 'eat'];
    final farewell = [
      'bye',
      'goodbye',
      'see you',
      'later',
      'thank',
      'thanks',
      'thank you'
    ];

    // --- Greetings ---
    if (_contains(input, greetings) ||
        _contains(input, ['how are you', 'how r u', 'how are u'])) {
      return _randomResponse([
        "Hey there! Ready to crush your workout today? 💪",
        "I'm feeling great! What about you — ready to get stronger?",
        "Feeling pumped and ready to help! What’s your goal for today?",
        "Hello! Let’s make some progress — how are you feeling?",
      ]);
    }

    // --- About FitVise ---
    if (_contains(input, ['fitvise', 'fit vise', 'fitvisee'])) {
      return "FitVise is your fitness buddy — helping with workouts, nutrition, motivation, and SEGAK. How can I help you today?";
    }

    // --- SEGAK Info ---
    if (_contains(input, ['segak', 'segakk'])) {
      return "SEGAK (Standardized Physical Fitness Test) assesses endurance and strength — with push-ups, sit-ups, and step tests. Want me to explain each part?";
    }

    // --- Creator / App Info ---
    if (_contains(
        input, ['who made you', 'who created you', 'who developed you'])) {
      return "I was created by MerahRed and the INNOVVICE team — fitness enthusiasts on a mission to make workouts simple and fun!";
    }

    if (_contains(input, ['assalamualaikum', 'aslm', 'assalam'])) {
      return "Waalaikumsalam! 🤝 How can I support your fitness journey today?";
    }

    if (_contains(input, ['maomao', 'mao mao', 'mao'])) {
      return "Aqeel, is that you? 😆 Ready to work out or talk SEGAK?";
    }

    if (_contains(input, ['what do you do', 'who are you', 'what are you'])) {
      return "I'm FitVise — your virtual coach! I can guide you through workouts, nutrition, and motivation. What do you need help with?";
    }

    if (_contains(
        input, ['your name', 'whats your name', 'what is your name'])) {
      return "I'm FitVise — your fitness companion 💪 What do you want to work on today?";
    }

    // --- Age / Small talk ---
    if (_contains(input, ['how old are you', 'your age'])) {
      return "Age doesn’t define fitness — consistency does! What’s your current goal?";
    }

    // --- Emotions / Mood ---
    if (_contains(input, ['sad', 'tired', 'exhaust', 'bored', 'stress'])) {
      return _randomResponse([
        "Sounds like you need a boost 💪 Try a short walk, stretch, or some music — it helps!",
        "Rest is progress too. Take a breather and refuel 💤",
        "You got this — low energy days happen. Want a quick 2-min energizer routine?",
      ]);
    }

    // --- Favorites ---
    if (_contains(input, ['favorite', 'favourite', 'like'])) {
      if (_contains(input, workouts)) {
        return "I love compound moves — squats, push-ups, and pull-ups 💪 What’s your favorite exercise?";
      }
      if (_contains(input, diet)) {
        return "I’d pick grilled chicken and veggies 🥗 Balanced, tasty, and energizing! What’s yours?";
      }
      return "I love seeing consistency — that’s the real win! What keeps you motivated?";
    }

    // --- Jokes ---
    if (_contains(input, ['joke', 'funny', 'laugh'])) {
      return _randomResponse([
        "Why did the dumbbell apply for a job? It wanted to work out! 😂",
        "Cardio is like taxes — you don’t like it, but you’ve got to do it! 💪",
        "Why don’t gym mirrors ever lie? Because they always reflect progress! 😆",
      ]);
    }

    // --- Help / Requests ---
    if (_contains(input, [
      'help',
      'need',
      'assist',
      'idea',
      'suggest',
      'can you',
      'could you'
    ])) {
      if (_contains(input, ['segak'])) {
        return "Sure! SEGAK includes push-ups, sit-ups, and a step test. Want me to help guide or track you?";
      }
      if (_contains(input, workouts)) {
        return "Absolutely! 💪 What’s your goal — muscle gain, endurance, or fat loss?";
      }
      if (_contains(input, diet)) {
        return "Let’s fuel your goals 🍽️ What’s your target — gain, lose, or maintain weight?";
      }
      return "I can help with workouts, SEGAK, and motivation. What do you need right now?";
    }

    // --- Fitness Goals ---
    if (_contains(input, ['lose', 'fat loss', 'cutting'])) {
      return _randomResponse([
        "For fat loss, eat slightly fewer calories than you burn — focus on protein and veggies 🥦",
        "Combine strength training and cardio for the best results 🔥",
        "Track your meals and stay consistent — that’s the secret weapon!",
      ]);
    }

    if (_contains(input, ['gain', 'muscle gain', 'bulking'])) {
      return _randomResponse([
        "For muscle gain, eat in a slight calorie surplus and lift consistently 💪",
        "Focus on compound lifts like squats, deadlifts, and bench press.",
        "Recovery is key — muscles grow when you rest well and eat enough protein!",
      ]);
    }

    if (_contains(input, diet)) {
      return _randomResponse([
        "Balanced meals = success 🥗 Lean proteins, complex carbs, and healthy fats.",
        "Drink enough water — hydration improves energy and recovery 💧",
        "Meal prep saves time and keeps your goals on track!",
      ]);
    }

    // --- Motivation ---
    if (_contains(input, ['motivate', 'give up', 'quit', 'cant', 'lazy'])) {
      return _randomResponse([
        "Don’t stop — even slow progress is still progress! 🔥",
        "Discipline beats motivation. Just start — the feeling comes later 💪",
        "Remember why you started. You’ve got this!",
      ]);
    }

    // --- Workout Types ---
    if (_contains(input, workouts)) {
      return _randomResponse([
        "Let’s move! 💪 What’s your focus — strength, cardio, or flexibility?",
        "Try 3x strength, 2x cardio, and 1x recovery day weekly — balance is key.",
        "Even 20 minutes counts! What kind of training do you enjoy?",
      ]);
    }

    if (_contains(input, ['cardio', 'run', 'jog', 'walk', 'bike'])) {
      return _randomResponse([
        "Cardio keeps your heart strong ❤️ Try intervals: 1 min fast, 2 min slow, repeat!",
        "Mix it up — running, cycling, brisk walking, all work great.",
        "150 minutes a week of cardio is ideal. What’s your favorite type?",
      ]);
    }

    if (_contains(input, ['strength', 'muscle', 'lift', 'weights'])) {
      return _randomResponse([
        "Strength builds muscle and confidence 💪 Focus on squats, push-ups, and pull-ups.",
        "Progressive overload — increase weight or reps each week for results.",
        "Remember: recovery builds muscle. Sleep well and stay fueled!",
      ]);
    }

    if (_contains(input, ['flexibility', 'stretch', 'yoga'])) {
      return _randomResponse([
        "Stretching improves recovery and reduces injury risk 🧘",
        "Add yoga or mobility work 2–3 times weekly for balance.",
        "Dynamic stretches before, static after — your body will thank you!",
      ]);
    }

    if (_contains(input, ['beginner', 'start', 'new'])) {
      return "Starting out? Awesome! 🎉 Begin with 3 sessions per week — squats, push-ups, planks, and walking.";
    }

    // --- Tech / AI Info ---
    if (_contains(input, ['chatgpt', 'claude', 'gpt', 'real ai'])) {
      return "I’m an offline, rule-based chatbot — no internet needed, just pure instant responses ⚡";
    }

    if (_contains(input, ['offline', 'internet', 'wifi'])) {
      return "Yup! I work fully offline 📴 Chat anytime, anywhere!";
    }

    // --- Farewell / Gratitude ---
    if (_contains(input, farewell)) {
      return _randomResponse([
        "See you soon! Stay consistent and keep pushing 💪",
        "Thanks for chatting! You’re doing amazing 🔥",
        "Goodbye for now! Remember — small steps make big changes!",
      ]);
    }

    // --- Language filter ---
    if (_contains(input, ['shit', 'fuck', 'bitch'])) {
      return "Hey! Let’s keep things positive 😊 Let’s talk fitness or SEGAK instead!";
    }

    // --- Default fallback ---
    List<String> defaults = [
      "I'm here to help 💬 Ask me about workouts, SEGAK, or nutrition!",
      "Interesting! Could you tell me more — training, food, or motivation?",
      "Hmm, not sure I caught that. Try something fitness-related?",
      "I want to help 💪 Could you rephrase that?",
      "I’m still learning! Ask about exercises, food, or recovery 😄",
    ];

    return defaults[_random.nextInt(defaults.length)];
  }

  String _randomResponse(List<String> responses) {
    return responses[_random.nextInt(responses.length)];
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      _controller.clear();
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        _messages.add({'sender': 'bot', 'text': _getResponse(text)});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FitVise Chat"),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.tips_and_updates_rounded,
                            size: 64, color: Colors.green.shade300),
                        const SizedBox(height: 16),
                        Text(
                          "Start a conversation!",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Ask me about workouts, nutrition, or motivation",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isUser = message['sender'] == 'user';

                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: isUser
                                ? Colors.green.shade600
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            message['text']!,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: TextField(
                      key: ValueKey(_currentHintIndex),
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: _hintTexts[_currentHintIndex],
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(
                            color: Colors.green.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                      onChanged: (_) {
                        setState(() {
                          _isTyping = _controller.text.isNotEmpty;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.green.shade600,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

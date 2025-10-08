import 'package:flutter/material.dart';
import 'dart:math';

class FitViseChatPage extends StatefulWidget {
  const FitViseChatPage({super.key});

  @override
  State<FitViseChatPage> createState() => _FitViseChatPageState();
}

class _FitViseChatPageState extends State<FitViseChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final Random _random = Random();

  String _getResponse(String input) {
    input = input.toLowerCase().trim();

    // Conversational questions
    if (_contains(input, [
      'how are you',
      'how r u',
      'how are u',
      'whats up',
      'what\'s up',
      'wassup',
      'sup',
      'yo'
    ])) {
      return _randomResponse([
        "I'm doing great, thanks for asking! 💪 More importantly, how are YOU feeling today?",
        "Feeling energized and ready to help! How's your fitness journey going?",
        "I'm here and pumped! What about you — how are you feeling?",
        "All good here! What's on your mind today?",
      ]);
    }
    if (_contains(
      input,
      ['FitVise', 'Fitvise', 'fitvise'],
    )) {
      return "FitVise is an application designed to help you achieve your fitness goals through personalized workout plans, nutrition advice, and motivational support.It also help student do the SEGAK test. How can I assist you on your fitness journey today?";
    }

    if (_contains(
      input,
      ['SEGAK', 'Segak', 'segak'],
    )) {
      return "SEGAK (Standardized Physical Fitness Test) is a fitness assessment used in some countries to evaluate physical health and endurance. It typically includes exercises like push-ups, sit-ups, and a step test.";
    }

    if (_contains(
        input, ['who made you', 'who created you', 'who developed you'])) {
      return "I was created by a team of passionate developers and fitness enthusiasts dedicated to helping people achieve their health goals. Our teams consist of MerahRed,Arif,Wafi and more. How can I assist you today?";
    }

    if (_contains(input, ['Assalamualaikum', 'assalamualaikum', 'aslm'])) {
      return "Waalaikumsalam! Mashallah brother my friend, how can I assist you on your fitness journey today?";
    }

    if (_contains(input, ['maomao', 'mao mao', 'mao'])) {
      return "Aqeel, is that you? UwU How can I assist you on your fitness journey today?";
    }

    if (_contains(input,
        ['what do you do', 'what can you do', 'who are you', 'what are you'])) {
      return "I'm your fitness coach! I can help with workout advice, nutrition tips, motivation, form checks, and answer questions about training, recovery, and reaching your goals. What would you like to know?";
    }

    if (_contains(
        input, ['your name', 'whats your name', 'what is your name'])) {
      return "I'm FitVise, your AI fitness coach! Think of me as your workout buddy who's always here to help. What can I assist you with?";
    }

    if (_contains(input, ['how old are you', 'your age'])) {
      return "Age is just a number in fitness! 😄 I'm here to help people of all ages reach their goals. What's your fitness goal?";
    }

    if (_contains(input, ['favorite', 'favourite', 'like'])) {
      if (_contains(input, ['exercise', 'workout', 'movement'])) {
        return "I love compound movements — squats, deadlifts, pull-ups! They work multiple muscles and give amazing results. What's YOUR favorite exercise?";
      }
      if (_contains(input, ['food', 'meal'])) {
        return "I'm a fan of balanced meals! Grilled chicken with sweet potato and veggies, or salmon with quinoa — fuel that builds strength! What do you like to eat?";
      }
      return "I'm passionate about consistency — showing up even when you don't feel like it! What about you, what keeps you motivated?";
    }

    if (_contains(input, ['joke', 'funny', 'laugh', 'humor'])) {
      return _randomResponse([
        "Why did the bodybuilder cross the road? To get to the other wide! 😄 Now let's get you to your goals!",
        "What's a gym rat's favorite type of music? Heavy metal! 🎵💪 Okay okay, what can I help you with?",
        "I don't skip leg day... or arm day... or any day really. Perks of being AI! 😅 What workout are you doing today?",
        "Why don't bodybuilders ever win at hide and seek? They're always spotted! 😂 Alright, how can I help you train?",
      ]);
    }

    if (_contains(input, ['bored', 'boring', 'entertain'])) {
      return "Bored? Perfect time for a quick workout! Try 50 jumping jacks, 20 push-ups, 30-second plank. Gets the blood flowing! Or we can chat — what's on your mind?";
    }

    if (_contains(input, ['weather', 'outside', 'rain', 'sunny'])) {
      return _randomResponse([
        "Rain or shine, there's always a way to train! Bad weather? Perfect for home workouts or gym day. What's your preference?",
        "Weather's just another variable! Outdoor run, indoor HIIT, or gym session — what sounds good to you today?",
      ]);
    }

    if (_contains(input, ['weekend', 'plans', 'today', 'tomorrow'])) {
      return "Every day is a chance to get better! Planning a workout? Rest day? Either way, make it count. What's your plan?";
    }

    if (_contains(input, ['help me', 'i need', 'can you', 'could you'])) {
      if (_contains(input, ['workout', 'exercise', 'train'])) {
        return "Absolutely! I'd love to help with your workout. Tell me: What's your goal? Building muscle, losing fat, getting stronger, or general fitness?";
      }
      if (_contains(input, ['diet', 'meal', 'eat', 'nutrition'])) {
        return "Sure! I can help with nutrition. What's your main goal — building muscle, losing weight, more energy, or just eating healthier?";
      }
      return "Of course! I'm here to help. What do you need — workout advice, nutrition tips, motivation, or something else?";
    }

    if (_contains(input, ['i\'m', 'im', 'i am', 'i feel'])) {
      if (_contains(
          input, ['happy', 'great', 'good', 'awesome', 'amazing', 'excited'])) {
        return _randomResponse([
          "That's amazing! 🎉 Love the positive energy! What's making today great?",
          "Yes! That's the spirit! Keep that energy going. What are you working on today?",
          "Awesome to hear! 💪 That good mood will fuel an amazing workout!",
        ]);
      }
      if (_contains(input, ['new', 'beginner', 'starting', 'just started'])) {
        return "Welcome to the journey! 🎉 Starting is the hardest part and you've already done it. Let's build a solid foundation — what would you like to work on first?";
      }
      if (_contains(input,
          ['confused', 'lost', 'don\'t know', 'dont know', 'not sure'])) {
        return "No worries, that's totally normal! Fitness can be overwhelming at first. Let's break it down — what confuses you most? Training? Nutrition? Where to start?";
      }
    }

    if (_contains(
        input, ['yes', 'yeah', 'yep', 'sure', 'ok', 'okay', 'alright'])) {
      return _randomResponse([
        "Great! Let's do this! What do you want to work on?",
        "Awesome! I'm here to help. What's your next question?",
        "Perfect! What else can I help you with?",
      ]);
    }

    if (_contains(input, ['no', 'nope', 'nah', 'not really'])) {
      return _randomResponse([
        "No problem! What would you prefer to talk about?",
        "That's okay! Is there something else I can help with?",
        "All good! Let me know what you need.",
      ]);
    }

    if (_contains(input, ['why', 'explain', 'tell me more', 'how come'])) {
      return "Great question! I'd love to explain. Could you be more specific? Are you asking about a specific exercise, nutrition principle, or training concept?";
    }

    // Greetings with variety
    if (_contains(input, ['hi', 'hello', 'hey', 'morning', 'evening'])) {
      return _randomResponse([
        "Hey there! Ready to crush your workout today? 💪",
        "Hello! What's on the agenda today — cardio, strength, or flexibility?",
        "Hey! How are you feeling? Let's make today count!",
        "Hi! Welcome back! What can I help you with today?",
      ]);
    }

    // Fatigue and tiredness
    if (_contains(
        input, ['tired', 'exhausted', 'fatigue', 'sleepy', 'drained'])) {
      return _randomResponse([
        "Rest is just as important as training. Try a light stretch or walk today, and prioritize 7-9 hours of sleep tonight.",
        "Listen to your body — fatigue means you need recovery. Hydrate well, eat some protein, and consider a rest day or active recovery.",
        "Feeling tired? Your body might need a break. Try foam rolling, yoga, or a 20-min walk instead of intense training today.",
      ]);
    }

    // Soreness and pain
    if (_contains(input, ['sore', 'ache', 'pain', 'hurt', 'injury'])) {
      if (_contains(input, ['injury', 'hurt badly', 'sharp pain', 'injured'])) {
        return "If you're experiencing sharp or persistent pain, please rest and consider seeing a healthcare professional. Your safety comes first!";
      }
      return _randomResponse([
        "Muscle soreness (DOMS) is normal 24-48hrs after training. Try light movement, stretching, or a warm bath to ease it.",
        "Sore muscles mean you're getting stronger! Stay hydrated, eat protein, and do some gentle stretching or walking to help recovery.",
        "Post-workout soreness? That's your muscles adapting! Keep moving lightly, sleep well, and it'll pass in a day or two.",
      ]);
    }

    // Nutrition questions
    if (_contains(input, [
      'hungry',
      'meal',
      'eat',
      'food',
      'diet',
      'nutrition',
      'protein',
      'carbs'
    ])) {
      if (_contains(input, ['before workout', 'pre workout', 'pre-workout'])) {
        return "Eat 1-2hrs before training: try a banana with peanut butter, oatmeal, or toast. Need quick energy? A small fruit 30min before works!";
      }
      if (_contains(input, ['after workout', 'post workout', 'post-workout'])) {
        return "Within 30-60min post-workout: aim for protein + carbs. Try a protein shake with banana, chicken with rice, or Greek yogurt with berries!";
      }
      if (_contains(input, ['protein', 'how much protein'])) {
        return "Aim for 0.8-1g of protein per pound of body weight daily. Spread it across meals: eggs, chicken, fish, tofu, Greek yogurt, and legumes are great!";
      }
      return _randomResponse([
        "Fuel smart! A balanced meal has protein (chicken, fish, tofu), complex carbs (rice, quinoa), healthy fats (avocado, nuts), and veggies.",
        "Hungry? Great sign your metabolism is working! Try protein + veggies: grilled chicken salad, salmon with broccoli, or a veggie omelet.",
        "Nutrition is 70% of results! Focus on whole foods, lean proteins, lots of water, and don't skip meals. Your body needs fuel to perform!",
      ]);
    }

    // Motivation and mindset
    if (_contains(input, [
      'motivate',
      'motivation',
      'inspire',
      'why',
      'give up',
      'quit',
      'can\'t',
      'cant'
    ])) {
      return _randomResponse([
        "Remember why you started! Every single rep, every healthy meal, every choice to show up — it all adds up. You're stronger than you think! 💪",
        "Motivation fades, but discipline lasts. You don't need to feel ready — you just need to start. Future you will thank present you!",
        "Bad days don't erase progress. You're building habits, not perfection. Show up, even if it's just for 10 minutes. Consistency beats intensity!",
        "Think about how good you'll feel AFTER the workout. That post-exercise high, the pride, the energy — it's worth pushing through! 🔥",
        "You're not just working out — you're proving to yourself that you keep promises. That's powerful. Keep going!",
      ]);
    }

    if (_contains(input, ['lazy', 'no energy', 'dont feel like'])) {
      return "We all have lazy days — what matters is showing up anyway! Do one small thing right now: stretch, drink water, or take 10 steps. Small wins build momentum!";
    }

    // Mental health and emotions
    if (_contains(input, [
      'sad',
      'down',
      'depressed',
      'anxious',
      'stress',
      'overwhelmed',
      'mental'
    ])) {
      return _randomResponse([
        "Tough days are part of life. Exercise releases endorphins — even a 10min walk can help. Be gentle with yourself today. 🫂",
        "Mental health is just as important as physical. Move your body gently, breathe deeply, and celebrate small wins. You're doing great just by being here.",
        "Feeling low? Try this: 5min breathing exercise, a short walk outside, or some gentle stretching. Movement helps mood. You've got this! ❤️",
      ]);
    }

    // Progress and results
    if (_contains(input, [
      'progress',
      'result',
      'not seeing',
      'plateau',
      'stuck',
      'not working'
    ])) {
      return _randomResponse([
        "Progress isn't always visible! Are you sleeping better? More energy? Lifting heavier? Those are wins too! Trust the process — changes take 4-6 weeks.",
        "Plateaus happen to everyone. Try changing your routine: increase weight, add more reps, try new exercises, or adjust your nutrition. Keep going!",
        "Results take time — body changes lag behind effort. Take progress photos, track strength gains, measure how you FEEL. The scale doesn't tell the full story!",
      ]);
    }

    //ai?
    if (_contains(
        input, ['real ai', 'are you ai', 'chatgpt', 'gpt', 'claude'])) {
      return "I'm a rule-based chatbot — not using ChatGPT or Claude. My answers are pre-built to simulate real conversation so users can get instant, offline guidance without internet or cost!";
    }

    //offline?
    if (_contains(input, ['offline', 'internet', 'wifi'])) {
      return "I work completely offline! 📴 No internet needed — that means users can chat with me anytime, anywhere, even without a connection.";
    }

    // Workout advice
    if (_contains(input, [
      'workout',
      'exercise',
      'training',
      'routine',
      'what should i do',
      'recommend'
    ])) {
      if (_contains(input, ['beginner', 'start', 'new'])) {
        return "Starting fresh? Awesome! Begin with 3 days/week: full-body workouts with basic moves (squats, push-ups, rows, planks). Focus on form first!";
      }
      if (_contains(input, ['cardio', 'running', 'burn fat'])) {
        return "For cardio: mix steady-state (30min moderate pace) with HIIT (20sec sprint, 40sec rest × 10 rounds). Start where you're comfortable!";
      }
      if (_contains(input, ['strength', 'muscle', 'build', 'gain'])) {
        return "Building muscle? Focus on: progressive overload (add weight/reps), compound lifts (squats, deadlifts, bench press), 8-12 reps, 3-4 sets. Eat enough protein!";
      }
      return _randomResponse([
        "Great question! What's your goal — strength, endurance, fat loss, or general fitness? That'll help me guide you better!",
        "A solid routine includes: strength training 3-4x/week, cardio 2-3x/week, flexibility work, and rest days. What area interests you most?",
        "Mix it up! Try: chest/tris, back/bis, legs/core splits, or upper/lower body days. Progressive overload is key — always challenge yourself!",
      ]);
    }

    // Hydration
    if (_contains(input, ['water', 'hydrate', 'drink', 'thirsty'])) {
      return "Hydration is crucial! Aim for half your body weight in ounces daily (e.g., 150lbs = 75oz). Drink more during workouts and hot days. Your performance depends on it!";
    }

    // Sleep and recovery
    if (_contains(input, ['sleep', 'rest', 'recovery', 'rest day'])) {
      return _randomResponse([
        "Sleep is where the magic happens! Muscle grows during rest, not during workouts. Aim for 7-9hrs, keep your room cool and dark. Recovery = gains!",
        "Rest days are NOT lazy days — they're growth days! Your body repairs and builds muscle when resting. Active recovery (walking, yoga) is great too!",
        "Quality sleep improves strength, focus, and fat loss. Create a routine: same bedtime, no screens 1hr before, cool room. Your body will thank you!",
      ]);
    }

    // Form and technique
    if (_contains(input,
        ['form', 'technique', 'how to', 'correct way', 'doing it right'])) {
      return "Form is EVERYTHING! Poor form = injury risk + less gains. Start with lighter weight, watch tutorials, record yourself, or ask a trainer. Quality over quantity!";
    }

    // Time and consistency
    if (_contains(input, ['no time', 'busy', 'schedule', 'when', 'how long'])) {
      return _randomResponse([
        "Even 20min counts! A quick HIIT session or bodyweight circuit is better than nothing. Consistency beats perfection — find what fits YOUR life!",
        "Busy schedule? Try: morning workouts (boost energy all day), lunch break movement, or split sessions. You have time — you just need to prioritize it!",
        "Quality over quantity! A focused 30min workout beats an unfocused hour. Make it non-negotiable like brushing your teeth. You're worth the time!",
      ]);
    }

    // Weight loss specific
    if (_contains(
        input, ['lose weight', 'weight loss', 'fat loss', 'slim', 'cut'])) {
      return "Weight loss = calorie deficit + consistency. Focus on: whole foods, strength training (builds metabolism), cardio, good sleep, and patience. Aim for 0.5-1lb/week!";
    }

    // Encouragement and celebration
    if (_contains(input, [
      'did it',
      'finished',
      'completed',
      'done',
      'great workout',
      'killed it'
    ])) {
      return _randomResponse([
        "YES! That's what I'm talking about! 🔥 You showed up and crushed it. That's discipline in action. Keep this momentum!",
        "AMAZING work! 💪 You're building a stronger version of yourself with every session. Be proud — most people don't even start!",
        "You absolute legend! 🎉 That's another win in the books. Your future self is high-fiving you right now!",
      ]);
    }

    // Goodbye
    if (_contains(
        input, ['bye', 'goodbye', 'see you', 'later', 'thanks', 'thank you'])) {
      return _randomResponse([
        "See you soon! Remember: consistency is key. You've got this! 💪",
        "Catch you later! Keep showing up — that's the real secret! Stay strong! 🔥",
        "Later! Your dedication is inspiring. Now go crush your goals! ❤️",
      ]);
    }

    // Small talk and acknowledgments
    if (input.length < 15 &&
        _contains(input, [
          'lol',
          'haha',
          'hehe',
          'wow',
          'nice',
          'cool',
          'awesome',
          'great'
        ])) {
      return _randomResponse([
        "😄 Glad you're in a good mood! What else can I help with?",
        "Haha! What's next on your fitness agenda?",
        "Nice! What do you want to work on today?",
      ]);
    }

    if (_contains(input, ['maybe', 'perhaps', 'possibly', 'might'])) {
      return "I hear you! Sometimes we need to think things through. What's holding you back? Let's work through it together!";
    }

    if (_contains(
        input, ['idk', 'i don\'t know', 'i dont know', 'not sure', 'dunno'])) {
      return "That's totally fine! Not knowing is the first step to learning. What would you like to figure out? I'm here to help!";
    }

    if (_contains(input, ['friend', 'with me', 'partner', 'together'])) {
      return "Training with someone is awesome for accountability and motivation! Having a workout buddy makes everything more fun. What are you two planning to do?";
    }

    if (_contains(input, ['question', 'ask you', 'wondering'])) {
      return "Ask away! I'm here for all your fitness questions. What's on your mind?";
    }

    // Default responses with personality
    List<String> defaults = [
      "I'm here to help! Ask me about workouts, nutrition, motivation, or recovery — what's on your mind?",
      "Interesting! Could you tell me more? Are you asking about training, nutrition, or something else?",
      "I'm learning every day! Try asking me about: workout tips, meal ideas, staying motivated, or recovery advice. What interests you?",
      "Hmm, not quite sure I got that! But I'm here to help with fitness, nutrition, and mindset. What can I assist you with?",
      "I want to help! Could you rephrase that? Or just tell me what you're working on today!",
    ];

    return defaults[_random.nextInt(defaults.length)];
  }

  // Helper: check if input contains any keyword
  bool _contains(String input, List<String> keywords) {
    return keywords.any((keyword) => input.contains(keyword));
  }

  // Helper: return random response
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
                        Icon(
                          Icons.fitness_center,
                          size: 64,
                          color: Colors.green.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Start a conversation!",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
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
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Say something...",
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
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

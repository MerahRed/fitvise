import 'package:FitVise/Global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'dart:async';

//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

class FitViseChatPage extends StatefulWidget {
  const FitViseChatPage({super.key});

  @override
  State<FitViseChatPage> createState() => _FitViseChatPageState();
}

class _FitViseChatPageState extends State<FitViseChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final List<String> _hintTexts = [
    "Say something...",
    "Ask me about workouts 💪",
    "Need motivation? Try asking me for one!",
    "Ask about SEGAK test tips 🏃",
    "Want a quick diet tip?",
    "Curious about recovery?",
  ];
  int _currentHintIndex = 0;
  Timer? _hintTimer;
  bool _isTyping = false;
  bool _isLoading = false;

  // ⚙️ API key
  final String _apiKey =
      "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";

  @override
  void initState() {
    super.initState();

    // Rotate hints every few seconds
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

  /// 🔹 Call the real AI API (OpenRouter / OpenAI style)
  Future<String> _fetchAIResponse(String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'openai/gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are FitVise-AI, a friendly and smart AI that knows everything about health and fitness.'
                  'Focus your answers to help user about fitness, workouts, nutrition, motivation, '
                  ''
                  'Keep your responses short, positive, and encouraging.'
                  'User name is $currentUsername and Weight about $currentWeight and Height is about $currentHeight and user bmi is $userStatus'
                  'talk about $_messages',
            },
            {'role': 'user', 'content': userMessage},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'] ?? "No response.";
      } else {
        return "Server error (${response.statusCode}): ${response.body}";
      }
    } catch (e) {
      return "Error fetching AI response: $e";
    }
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      _controller.clear();
      _isLoading = true;
    });

    final aiReply = await _fetchAIResponse(text);

    setState(() {
      _messages.add({'sender': 'bot', 'text': aiReply});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FitVise Chat"),
        backgroundColor: Colors.teal,
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
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: Colors.teal.shade300,
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
                          "Ask me about workouts, nutrition, or SEGAK",
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
                                ? Colors.tealAccent.shade700
                                : Colors.grey.shade900,
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
                              color: isUser ? Colors.white : Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "FitVise is thinking...",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ),
          const Divider(height: 1),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                                color: Colors.tealAccent.shade700,
                                width: 2,
                              ),
                            ),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: Colors.tealAccent.shade700,
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}

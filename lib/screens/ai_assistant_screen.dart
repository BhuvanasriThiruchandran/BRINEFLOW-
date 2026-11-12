
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/api_config.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;

  final List<Map<String, String>> _messages = [
    {
      'role': 'ai',
      'message':
          'Hello! I am BrineFlow AI. Ask me about your ponds, weather, yield, profit, alerts, or saltpan operations.',
    },
  ];

  final List<String> _quickQuestions = [
    'What is BrineFlow?',
    'Which pond needs attention?',
    'How does Brine Readiness Score work?',
    'What is the predicted yield?',
  ];

  // ============================================================
  // SEND MESSAGE TO FLASK
  // ============================================================

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();

    if (text.isEmpty || _isLoading) {
      return;
    }

    setState(() {
      _messages.add({
        'role': 'user',
        'message': text,
      });

      _controller.clear();
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/api/chat'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': text,
        }),
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final reply = data['reply'];

        setState(() {
          _messages.add({
            'role': 'ai',
            'message': reply?.toString() ??
                'I received an empty response from the AI.',
          });
        });
      } else {
        final data = jsonDecode(response.body);

        setState(() {
          _messages.add({
            'role': 'ai',
            'message': data['error']?.toString() ??
                'Sorry, I could not process your question.',
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'role': 'ai',
          'message':
              'I could not connect to the BrineFlow server. Please make sure the Flask backend is running on port 5000.',
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });

      _scrollToBottom();
    }
  }

  // ============================================================
  // QUICK QUESTION
  // ============================================================

  void _askQuestion(String question) {
    if (_isLoading) return;

    _controller.text = question;
    _sendMessage();
  }

  // ============================================================
  // SCROLL TO BOTTOM
  // ============================================================

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ============================================================
  // UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'BrineFlow AI',
      subtitle: 'Intelligent saltpan assistant',
      child: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                // ==================================================
                // AI HEADER
                // ==================================================

                GlassCard(
                  color: AppTheme.ocean.withValues(alpha: 0.06),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppTheme.ocean,
                              AppTheme.cyan,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BrineFlow AI',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Ask about your saltpan operations.',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Online indicator
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.success.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 7,
                              color: AppTheme.success,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'ONLINE',
                              style: TextStyle(
                                color: AppTheme.success,
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // SUGGESTED QUESTIONS
                // ==================================================

                const Text(
                  'Suggested questions',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _quickQuestions.map((question) {
                    return ActionChip(
                      avatar: const Icon(
                        Icons.auto_awesome,
                        size: 15,
                      ),
                      label: Text(question),
                      onPressed: _isLoading
                          ? null
                          : () => _askQuestion(question),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // CHAT MESSAGES
                // ==================================================

                ..._messages.map(
                  (message) => _ChatBubble(
                    isAi: message['role'] == 'ai',
                    message: message['message']!,
                  ),
                ),

                // ==================================================
                // LOADING INDICATOR
                // ==================================================

                if (_isLoading)
                  const _TypingIndicator(),
              ],
            ),
          ),

          // ========================================================
          // INPUT
          // ========================================================

          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    enabled: !_isLoading,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: _isLoading
                          ? 'BrineFlow AI is thinking...'
                          : 'Ask BrineFlow AI...',
                      prefixIcon: const Icon(
                        Icons.chat_bubble_outline_rounded,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppTheme.ocean,
                        AppTheme.cyan,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    onPressed: _isLoading ? null : _sendMessage,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 19,
                            height: 19,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.arrow_upward_rounded,
                            color: Colors.white,
                          ),
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

// ================================================================
// CHAT BUBBLE
// ================================================================

class _ChatBubble extends StatelessWidget {
  final bool isAi;
  final String message;

  const _ChatBubble({
    required this.isAi,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 620,
        ),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isAi
              ? Theme.of(context).colorScheme.surface
              : AppTheme.ocean,
          borderRadius: BorderRadius.circular(16),
          border: isAi
              ? Border.all(
                  color: AppTheme.borderLight,
                )
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isAi) ...[
              const Icon(
                Icons.auto_awesome_rounded,
                size: 18,
                color: AppTheme.ocean,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: isAi ? null : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// TYPING INDICATOR
// ================================================================

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.borderLight,
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              size: 16,
              color: AppTheme.ocean,
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Thinking...',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

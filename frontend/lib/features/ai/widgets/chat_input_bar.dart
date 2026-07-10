import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ai_provider.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({super.key});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    _controller.clear();

    await context.read<AIProvider>().sendMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AIProvider>().loading;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF182135),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Attachments will be added later
            },
            icon: const Icon(Icons.attach_file_rounded, color: Colors.white70),
          ),

          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),

              textInputAction: TextInputAction.send,

              onSubmitted: (_) => _send(),

              decoration: const InputDecoration(
                hintText: "Ask MindSync AI anything...",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              // Voice assistant (future)
            },
            icon: const Icon(Icons.mic_none_rounded, color: Colors.white70),
          ),

          loading
              ? const Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF7C5CFF),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _send,
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                  ),
                ),
        ],
      ),
    );
  }
}

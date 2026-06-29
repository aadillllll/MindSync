import 'package:flutter/material.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            icon: const Icon(Icons.attach_file_rounded, color: Colors.white70),
          ),

          const Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Ask MindSync AI anything...",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic_none_rounded, color: Colors.white70),
          ),

          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF7C5CFF),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

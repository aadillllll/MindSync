import 'package:flutter/material.dart';

class AIHeader extends StatelessWidget {
  const AIHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Drawer Button
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 28),
        ),

        const SizedBox(width: 10),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MindSync AI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "Your personal productivity companion",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ],
          ),
        ),

        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF7C5CFF).withValues(alpha: 0.18),
          ),
          child: const Icon(Icons.auto_awesome, color: Color(0xFF7C5CFF)),
        ),
      ],
    );
  }
}

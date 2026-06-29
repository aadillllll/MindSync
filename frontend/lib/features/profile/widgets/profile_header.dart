import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 34,
          backgroundColor: Color(0xFF7C5CFF),
          child: Icon(Icons.person, color: Colors.white, size: 34),
        ),

        const SizedBox(width: 18),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Adil Muhammed N",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 4),

              Text(
                "BCA(Hons) 2nd Year",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .06),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.edit_rounded, color: Colors.white70),
        ),
      ],
    );
  }
}

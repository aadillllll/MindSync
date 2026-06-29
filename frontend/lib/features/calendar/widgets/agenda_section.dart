import 'package:flutter/material.dart';

import 'event_card.dart';

class AgendaSection extends StatelessWidget {
  const AgendaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Agenda",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        EventCard(
          title: "DBMS Lecture",
          time: "09:00 AM",
          location: "Room 402",
          color: Colors.blueAccent,
        ),

        EventCard(
          title: "Flutter Development",
          time: "02:00 PM",
          location: "MindSync Project",
          color: Color(0xFF7C5CFF),
        ),

        EventCard(
          title: "Gym Session",
          time: "06:00 PM",
          location: "Fitness Center",
          color: Colors.green,
        ),
      ],
    );
  }
}

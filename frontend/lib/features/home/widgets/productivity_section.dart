import 'package:flutter/material.dart';

import 'productivity_ring.dart';
import 'productivity_stat_card.dart';

class ProductivitySection extends StatelessWidget {
  const ProductivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B2336), Color(0xFF151C2D)],
        ),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(
                Icons.trending_up_rounded,
                color: Colors.white70,
                size: 22,
              ),
              const SizedBox(width: 10),

              const Expanded(
                child: Text(
                  "Productivity Overview",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "This Week",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white70,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // First Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductivityRing(progress: 0.84, percentage: 84),

              const SizedBox(width: 14),

              Expanded(
                child: SizedBox(
                  height: 150,
                  child: ProductivityStatCard(
                    icon: Icons.task_alt_rounded,
                    iconColor: Colors.deepPurpleAccent,
                    value: "92",
                    title: "Tasks",
                    progress: "+18%",
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Second Row
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 150,
                  child: ProductivityStatCard(
                    icon: Icons.track_changes,
                    iconColor: Colors.blueAccent,
                    value: "12",
                    title: "Habits",
                    progress: "+24%",
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: SizedBox(
                  height: 150,
                  child: ProductivityStatCard(
                    icon: Icons.timer_outlined,
                    iconColor: Colors.greenAccent,
                    value: "14.5",
                    title: "Focus Hours",
                    progress: "+20%",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

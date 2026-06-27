import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/glass_card.dart';

class AIDailyBriefingCard extends StatelessWidget {
  const AIDailyBriefingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff2D2A8C), Color(0xff253A8F), Color(0xff18346A)],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// Purple Glow
            Positioned(
              top: -60,
              right: -40,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple.withOpacity(.22),
                ),
              ),
            ),

            /// Robot Illustration
            Positioned(
              top: 8,
              right: -18,
              child: Image.asset(
                "assets/images/robot.png",
                width: 170,
                fit: BoxFit.contain,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(.25),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.psychology_alt_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Text("AI Daily Briefing", style: AppTextStyles.title),
                    ],
                  ),

                  const SizedBox(height: 26),

                  SizedBox(
                    width: 205,
                    child: Text(
                      "Today looks busy,\nbut you've got this!",
                      style: AppTextStyles.headline.copyWith(
                        fontSize: 20,
                        height: 1.35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _StatItem(
                        icon: Icons.assignment_rounded,
                        value: "2",
                        label: "Assignments\ndue",
                        color: Color(0xff8D63FF),
                      ),

                      _StatItem(
                        icon: Icons.calendar_today_rounded,
                        value: "1",
                        label: "Meeting\ntoday",
                        color: Color(0xff4EA1FF),
                      ),

                      _StatItem(
                        icon: Icons.local_fire_department_rounded,
                        value: "12",
                        label: "Habit streak\ndays",
                        color: Color(0xff66D16F),
                      ),

                      _StatItem(
                        icon: Icons.bar_chart_rounded,
                        value: "84%",
                        label: "Productivity\nscore",
                        color: Color(0xffF5C14B),
                      ),
                    ],
                  ),

                  const SizedBox(height: 26),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.18),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          color: Color(0xffC47CFF),
                          size: 20,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Recommended Focus: ",
                                  style: AppTextStyles.body.copyWith(
                                    color: const Color(0xffC47CFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                TextSpan(
                                  text: "Finish DBMS Assignment first.",
                                  style: AppTextStyles.body,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white54,
                          size: 16,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 28,
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 6),

          SizedBox(
            height: 36,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

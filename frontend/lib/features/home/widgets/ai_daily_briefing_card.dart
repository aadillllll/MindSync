import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/glass_card.dart';
import '../providers/dashboard_provider.dart';

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
            Positioned(
              top: -60,
              right: -40,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple.withValues(alpha: .22),
                ),
              ),
            ),

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
              child: Consumer<DashboardProvider>(
                builder: (context, provider, child) {
                  final dashboard = provider.dashboard;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withValues(alpha: .25),
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
                          provider.isLoading
                              ? "Preparing your personalized AI briefing..."
                              : (dashboard?.aiBrief ??
                                    "Welcome back! Let's have a productive day."),
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
                        children: [
                          _StatItem(
                            icon: Icons.assignment_rounded,
                            value:
                                "${dashboard?.upcomingDeadlines.length ?? 0}",
                            label: "Assignments\ndue",
                            color: const Color(0xff8D63FF),
                          ),
                          const _StatItem(
                            icon: Icons.calendar_today_rounded,
                            value: "0",
                            label: "Meeting\ntoday",
                            color: Color(0xff4EA1FF),
                          ),
                          _StatItem(
                            icon: Icons.local_fire_department_rounded,
                            value: "${dashboard?.analytics.habitStreak ?? 0}",
                            label: "Habit streak\ndays",
                            color: const Color(0xff66D16F),
                          ),
                          _StatItem(
                            icon: Icons.bar_chart_rounded,
                            value:
                                "${dashboard?.analytics.productivityScore ?? 0}%",
                            label: "Productivity\nscore",
                            color: const Color(0xffF5C14B),
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
                          color: Colors.black.withValues(alpha: .18),
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
                                      text:
                                          dashboard?.recommendedFocus ??
                                          "You're all caught up!",
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
                  );
                },
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
              color: color.withValues(alpha: .15),
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

import 'package:flutter/material.dart';

import '../../../core/widgets/gradient_background.dart';

import '../widgets/greeting_header.dart';
import '../widgets/ai_daily_briefing_card.dart';
import '../widgets/focus_section.dart';
import '../widgets/deadlines_section.dart';
import '../widgets/schedule_section.dart';
import '../widgets/habits_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/ai_assistant_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Greeting Header
                const GreetingHeader(),

                const SizedBox(height: 28),

                /// AI Daily Briefing
                const AIDailyBriefingCard(),

                const SizedBox(height: 32),

                /// Today's Focus
                const FocusSection(),

                const SizedBox(height: 30),

                /// Upcoming Deadlines
                const DeadlinesSection(),

                const SizedBox(height: 30),

                /// Today's Schedule
                const ScheduleSection(),

                const SizedBox(height: 28),

                /// Habits
                const HabitsCard(),

                const SizedBox(height: 28),

                /// Quick Actions
                const QuickActions(),

                const SizedBox(height: 30),

                /// AI Assistant
                const AIAssistantCard(),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

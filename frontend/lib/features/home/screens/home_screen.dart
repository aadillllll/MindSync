import 'package:flutter/material.dart';

import '../../../core/widgets/gradient_background.dart';

import '../widgets/greeting_header.dart';
import '../widgets/ai_daily_briefing_card.dart';
import '../widgets/focus_section.dart';
import '../widgets/quick_actions.dart';

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
                /// Greeting
                const GreetingHeader(),

                const SizedBox(height: 28),

                /// AI Daily Briefing
                const AIDailyBriefingCard(),

                const SizedBox(height: 32),

                /// Today's Focus
                const FocusSection(),

                const SizedBox(height: 32),

                /// Quick Actions
                const QuickActions(),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

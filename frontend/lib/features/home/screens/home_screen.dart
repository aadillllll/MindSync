import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/gradient_background.dart';

import '../providers/dashboard_provider.dart';

import '../widgets/greeting_header.dart';
import '../widgets/ai_daily_briefing_card.dart';
import '../widgets/focus_section.dart';
import '../widgets/deadlines_section.dart';
import '../widgets/schedule_section.dart';
import '../widgets/habits_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/productivity_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashboardProvider>();

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: dashboardProvider.refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
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

                  const SizedBox(height: 30),

                  const ProductivitySection(),

                  const SizedBox(height: 50),

                  /// Quick Actions
                  const QuickActions(),

                  const SizedBox(height: 30),

                  /// AI Assistant
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/profile/providers/profile_provider.dart';
import 'features/splash/screens/splash_screen.dart';
import 'features/tasks/providers/task_provider.dart';
import 'features/calendar/providers/calendar_provider.dart';
import 'features/goals/providers/goal_provider.dart';
import 'features/habits/providers/habit_provider.dart';
import 'features/notes/providers/note_provider.dart';
import 'features/ai/providers/ai_provider.dart';
import 'features/analytics/providers/analytics_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MindSyncApp());
}

class MindSyncApp extends StatelessWidget {
  const MindSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskProvider>(create: (_) => TaskProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),

        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(),
        ),

        ChangeNotifierProvider(create: (_) => CalendarProvider()),
        ChangeNotifierProvider<GoalProvider>(create: (_) => GoalProvider()),

        ChangeNotifierProvider(create: (_) => AnalyticsProvider()),

        ChangeNotifierProvider(create: (_) => AIProvider()),

        ChangeNotifierProvider(create: (_) => HabitProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MindSync',
        theme: AppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}

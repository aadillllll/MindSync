import 'package:flutter/material.dart';

import 'app/main_screen.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MindSyncApp());
}

class MindSyncApp extends StatelessWidget {
  const MindSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindSync',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.darkTheme,

      home: const MainScreen(),
    );
  }
}

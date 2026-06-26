import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(const MindSyncApp());
}

class MindSyncApp extends StatelessWidget {
  const MindSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindSync',
      theme: AppTheme.darkTheme,
      home: const Scaffold(
        body: Center(child: Text('MindSync', style: TextStyle(fontSize: 28))),
      ),
    );
  }
}

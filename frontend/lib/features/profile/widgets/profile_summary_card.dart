import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile_provider.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({super.key});

  Widget _stat({
    required String value,
    required String title,
    required double valueFontSize,
    required double labelFontSize,
    required double spacing,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: valueFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: spacing),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              maxLines: 1,
              style: TextStyle(color: Colors.white60, fontSize: labelFontSize),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>().profile;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final padding = (width * 0.055).clamp(16.0, 24.0);
        final valueFont = (width * 0.065).clamp(18.0, 26.0);
        final labelFont = (width * 0.032).clamp(10.0, 13.0);
        final spacing = (width * 0.015).clamp(4.0, 8.0);

        return Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: const Color(0xFF182135),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              _stat(
                value: "--",
                title: "Attendance",
                valueFontSize: valueFont,
                labelFontSize: labelFont,
                spacing: spacing,
              ),
              _stat(
                value: "${profile?.productivityScore ?? 0}",
                title: "Productivity",
                valueFontSize: valueFont,
                labelFontSize: labelFont,
                spacing: spacing,
              ),
              _stat(
                value: "0",
                title: "Tasks",
                valueFontSize: valueFont,
                labelFontSize: labelFont,
                spacing: spacing,
              ),
              _stat(
                value: "0",
                title: "Streak",
                valueFontSize: valueFont,
                labelFontSize: labelFont,
                spacing: spacing,
              ),
            ],
          ),
        );
      },
    );
  }
}

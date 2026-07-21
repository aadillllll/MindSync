import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

class DashboardSectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const DashboardSectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, bottom: 14),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.title.copyWith(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

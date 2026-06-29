import 'package:flutter/material.dart';

import '../widgets/logout_button.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/quick_action_tile.dart';
import '../widgets/settings_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),

              const SizedBox(height: 28),

              const ProfileSummaryCard(),

              const SizedBox(height: 32),

              const Text(
                "Quick Actions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              const QuickActionTile(
                icon: Icons.person_outline_rounded,
                title: "Edit Profile",
              ),

              const QuickActionTile(
                icon: Icons.notifications_none_rounded,
                title: "Notifications",
              ),

              const QuickActionTile(
                icon: Icons.dark_mode_outlined,
                title: "Appearance",
              ),

              const QuickActionTile(
                icon: Icons.download_rounded,
                title: "Export Data",
              ),

              const SizedBox(height: 30),

              const Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              SettingsSection(),

              const SizedBox(height: 32),

              LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}

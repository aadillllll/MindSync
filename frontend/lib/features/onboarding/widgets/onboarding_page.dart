import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final IconData mainIcon;
  final List<IconData> floatingIcons;
  final String title;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.mainIcon,
    required this.floatingIcons,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          const SizedBox(height: 40),

          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Illustration(mainIcon: mainIcon, floatingIcons: floatingIcons),

                const SizedBox(height: 50),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 17,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Illustration extends StatelessWidget {
  final IconData mainIcon;
  final List<IconData> floatingIcons;

  const _Illustration({required this.mainIcon, required this.floatingIcons});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      width: 310,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 270,
            width: 270,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.deepPurple.withValues(alpha: .35),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFF5B8CFF)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withValues(alpha: .45),
                  blurRadius: 30,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Icon(mainIcon, color: Colors.white, size: 70),
          ),

          Positioned(
            left: 18,
            top: 55,
            child: _MiniIcon(icon: floatingIcons[0]),
          ),

          Positioned(
            right: 15,
            top: 70,
            child: _MiniIcon(icon: floatingIcons[1]),
          ),

          Positioned(
            left: 35,
            bottom: 30,
            child: _MiniIcon(icon: floatingIcons[2]),
          ),

          Positioned(
            right: 25,
            bottom: 15,
            child: _MiniIcon(icon: floatingIcons[3]),
          ),
        ],
      ),
    );
  }
}

class _MiniIcon extends StatelessWidget {
  final IconData icon;

  const _MiniIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: 68,
      decoration: BoxDecoration(
        color: const Color(0xFF16223A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Icon(icon, color: const Color(0xFF8B5CF6), size: 32),
    );
  }
}

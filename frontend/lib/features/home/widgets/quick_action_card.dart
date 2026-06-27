import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';

class QuickActionCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  State<QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<QuickActionCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: _pressed ? .97 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 118,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.gradient,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.gradient.first.withValues(alpha: .35),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.black.withValues(alpha: .28),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon, size: 34, color: Colors.white),

                  const SizedBox(height: 14),

                  Text(
                    widget.title,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

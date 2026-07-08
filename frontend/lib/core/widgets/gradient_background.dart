import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base Background
        Container(decoration: const BoxDecoration(color: AppColors.background)),

        // Purple Glow
        Positioned(
          top: -120,
          right: -80,
          child: _GlowCircle(
            size: 280,
            color: AppColors.primary.withValues(alpha: .35),
          ),
        ),

        // Cyan Glow
        Positioned(
          bottom: -120,
          left: -80,
          child: _GlowCircle(
            size: 260,
            color: AppColors.secondary.withValues(alpha: .25),
          ),
        ),

        // Content
        SafeArea(child: child),
      ],
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

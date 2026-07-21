import 'package:flutter/material.dart';

class ProductivityRing extends StatelessWidget {
  final double progress;
  final int percentage;
  final double size; // caller can override; defaults to original 140

  const ProductivityRing({
    super.key,
    required this.progress,
    required this.percentage,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use the smaller of requested size vs available space
        double outerSize = size;
        if (constraints.maxWidth.isFinite && constraints.maxWidth < outerSize) {
          outerSize = constraints.maxWidth;
        }
        if (constraints.maxHeight.isFinite &&
            constraints.maxHeight < outerSize) {
          outerSize = constraints.maxHeight;
        }

        // Keep original proportions (120/140 ring, 10/140 stroke, 34/140 font)
        final ringSize = outerSize * (120 / 140);
        final strokeWidth = outerSize * (10 / 140);
        final percentFontSize = outerSize * (34 / 140);
        final labelFontSize = outerSize * (15 / 140);

        return SizedBox(
          width: outerSize,
          height: outerSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: ringSize,
                height: ringSize,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: strokeWidth,
                  backgroundColor: Colors.white.withValues(alpha: .08),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF7C5CFF)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(outerSize * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '$percentage%',
                        style: TextStyle(
                          fontSize: percentFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: outerSize * (2 / 140)),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Productive",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: labelFontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

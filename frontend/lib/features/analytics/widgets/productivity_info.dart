import 'package:flutter/material.dart';

class ProductivityInfo extends StatelessWidget {
  const ProductivityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Productivity Score",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 8),

        Text(
          "This week you're performing great!",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),

        SizedBox(height: 30),

        Row(
          children: [
            Icon(
              Icons.trending_up_rounded,
              color: Colors.greenAccent,
              size: 36,
            ),

            SizedBox(width: 14),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "+12%",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "vs last week",
                  style: TextStyle(color: Colors.white60, fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

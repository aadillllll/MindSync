import 'package:flutter/material.dart';

import 'habit_model.dart';

const habits = [
  HabitModel(
    title: "Water",
    subtitle: "8/10 cups",
    percentage: "80%",
    progress: .80,
    color: Color(0xff8D63FF),
    icon: Icons.water_drop,
  ),

  HabitModel(
    title: "Study",
    subtitle: "2/3 hrs",
    percentage: "66%",
    progress: .66,
    color: Color(0xff57A4FF),
    icon: Icons.menu_book,
  ),

  HabitModel(
    title: "Exercise",
    subtitle: "3/4 days",
    percentage: "75%",
    progress: .75,
    color: Color(0xff7EE787),
    icon: Icons.directions_run,
  ),

  HabitModel(
    title: "Sleep",
    subtitle: "4/8 hrs",
    percentage: "50%",
    progress: .50,
    color: Color(0xffF6C453),
    icon: Icons.nightlight_round,
  ),
];

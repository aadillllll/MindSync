class WeeklyActivityModel {
  final String day;

  final int completedTasks;

  final int completedHabits;

  const WeeklyActivityModel({
    required this.day,
    required this.completedTasks,
    required this.completedHabits,
  });

  int get total => completedTasks + completedHabits;
}

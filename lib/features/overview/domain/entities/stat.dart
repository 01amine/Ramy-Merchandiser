class ProductivityStats {
  final int completedTasks;
  final int totalTasks;
  final double focusTime; // Hours spent in focus mode
  final double distractions; // Percentage of distractions

  ProductivityStats({
    required this.completedTasks,
    required this.totalTasks,
    required this.focusTime,
    required this.distractions,
  });

  double get completionRate => totalTasks == 0 ? 0 : completedTasks / totalTasks;
}

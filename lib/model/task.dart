class Task {
  String title;
  bool isCompleted;
  DateTime deadline;
  DateTime? completionDate;

  Task({
    required this.title,
    required this.deadline,
    this.isCompleted = false,
    this.completionDate,
  });
}
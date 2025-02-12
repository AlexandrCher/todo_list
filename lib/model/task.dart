class Task {
  String title;
  bool isCompleted;
  DateTime? deadline;
  DateTime? completionDate;
  String category;

  Task({
    required this.title,
    this.deadline,
    required this.category,
    this.isCompleted = false,
    this.completionDate,
  });
}
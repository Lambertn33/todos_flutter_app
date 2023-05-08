class Todo {
  final String? id;
  final String title;
  final String description;
  final bool isCompleted;

  Todo(
      {this.id,
      required this.title,
      required this.description,
      required this.isCompleted});
}

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  String title;
  String id;
  String description;
  DateTime createdTime;
  bool isDone;
  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
    required this.id,
    this.isDone = false,
  });
  
}

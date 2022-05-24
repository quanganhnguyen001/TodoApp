import 'package:flutter/foundation.dart';
import 'package:simple_todo_app/model/todo.dart';

class TodosProvider extends ChangeNotifier{
  List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the Dog 🐕', id: '',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Plan Jacobs birthday party 🎉🥳', id: '',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Buy Food 😋',
      description: '''
      - Milk
      - Bread
      - Water''', id: '',
    ),
  ];
  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted => _todos.where((todo) => todo.isDone == true).toList();


  void addTodo(Todo todo){
    _todos.add(todo);
    notifyListeners();
  }

  void removedTodo(Todo todo){
    _todos.remove(todo);
    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo){
    todo.isDone = !todo.isDone;
    notifyListeners();
    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description){
    todo.title = title;
    todo.description = description;

    notifyListeners();
  }
}
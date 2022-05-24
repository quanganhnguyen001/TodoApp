import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/provider/todos.dart';
import 'package:simple_todo_app/widget/todo_widget.dart';


class TodoList extends StatelessWidget {
  const TodoList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return todos.isEmpty
      ? Center(
        child: Text(
          'No todos',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      )

    : ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index){
        final todo = todos[index];
        return TodoWidget(todo: todo);
      },
      separatorBuilder: (BuildContext context, int index) => Container(height: 8,),
      itemCount: todos.length,
    );
  }
}
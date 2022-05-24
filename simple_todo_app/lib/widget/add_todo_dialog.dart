import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/model/todo.dart';
import 'package:simple_todo_app/provider/todos.dart';
import 'package:simple_todo_app/widget/todo_form.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({Key? key}) : super(key: key);

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final formkey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: formkey,// use to validate
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add Todo",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            ),
            SizedBox(height: 8,),
            TodoForm(
              onChangedTitle: (title) => setState(() => this.title = title,),
              onChangedDescription: (description) => setState(() => this.description = description,),
              onSavedTodo: addTodo,
            ),
          ],
        ),
      ),
    );
  }
  void addTodo(){
    final isValid = formkey.currentState!.validate();// call validator in title

    if(!isValid){
      return;// return message erro
    }else{
      final todo = Todo(
        createdTime: DateTime.now(),
        title: title,
        description: description,
        id: DateTime.now().toString(),
      );
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
      
    }
  }
}

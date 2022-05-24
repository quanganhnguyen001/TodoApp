import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/model/todo.dart';
import 'package:simple_todo_app/provider/todos.dart';
import 'package:simple_todo_app/widget/todo_form.dart';

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({ Key? key, required this.todo }) : super(key: key);
  final Todo todo;

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formkey = GlobalKey<FormState>();// make sure title always fill 
  late String title;
  late String description;

  @override
  void initState() {
    title = widget.todo.title;
    description = widget.todo.description;
    super.initState();
  }
  
  
  void saveTodo() {
    final isValid = _formkey.currentState!.validate();

    if (!isValid){
      return;
    } else{
      final provider = Provider.of<TodosProvider>(context, listen: false);

      provider.updateTodo(widget.todo, title, description);

      Navigator.of(context).pop();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
        actions: [
          IconButton(onPressed: (){
            final provider = Provider.of<TodosProvider>(context, listen: false);
            provider.removedTodo(widget.todo);

            Navigator.of(context).pop();
          }, 
          icon: Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: TodoForm(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() {
              this.title = title;
            }), 
            onChangedDescription: (description) => setState(() {
              this.description = description;
            }), 
            onSavedTodo: saveTodo,
          ),
        ),
      ),
    );
  

  }
}
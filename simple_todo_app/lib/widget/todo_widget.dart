import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/model/todo.dart';
import 'package:simple_todo_app/page/edit_todo_page.dart';
import 'package:simple_todo_app/provider/todos.dart';
import 'package:simple_todo_app/utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  const TodoWidget({ Key? key, required this.todo }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Slidable(
      
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.green,
            icon: Icons.edit,
            label: "Edit", onPressed: (BuildContext context) => editTodo(context, todo),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            icon: Icons.delete,
            backgroundColor: Colors.red,
            label: "Delete", onPressed: (BuildContext context) => deleteTodo(context,todo),
          ),
        ],
      ),
      key: Key(todo.id),
      child: buildTodo(context)
    ),
  );

  Widget buildTodo(BuildContext context) => GestureDetector(
    onTap: () => editTodo(context, todo),
    child: Container(
        color: Colors.yellow,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              activeColor: Colors.blue,
              checkColor: Colors.white,
              value: todo.isDone,
              onChanged: (_){
                final provider = Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(todo);
  
                Utils.showSnackBar(
                  context,
                  isDone ? 'Task Completed' : 'Task marked incomplete'
                );
              },
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.red,
                  ),
                  ),
                  if (todo.description.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      todo.description,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
  );
  void deleteTodo(BuildContext context, Todo todo){
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removedTodo(todo);

    Utils.showSnackBar(context,'Deleted the task');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditTodoPage(todo: todo,)));
}
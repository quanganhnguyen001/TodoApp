import 'package:flutter/material.dart';
import 'package:simple_todo_app/widget/add_todo_dialog.dart';
import 'package:simple_todo_app/widget/completed_list.dart';
import 'package:simple_todo_app/widget/todo_list.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoList(),
      CompletedList(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("TodoApp"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: "Todos"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.done,
              size: 28,
            ),
            label: "Completed",
          ),
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AddTodoDialog();
          },
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

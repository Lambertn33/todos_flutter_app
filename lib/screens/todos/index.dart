import 'package:flutter/material.dart';
import 'package:todos_http_app/helpers/constants.dart';
import 'package:todos_http_app/screens/todos/create.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  void navigateToAddTodoPage() {
    final addTodoRoute =
        MaterialPageRoute(builder: (context) => const CreateTodo());
    Navigator.of(context).push(addTodoRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(Constants.indexAppTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddTodoPage,
        label: Text(Constants.createAppTitle),
      ),
    );
  }
}

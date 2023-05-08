import 'package:flutter/material.dart';
import 'package:todos_http_app/helpers/constants.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(Constants.indexAppTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){},
       label: Text(Constants.createAppTitle)),
    );
  }
}
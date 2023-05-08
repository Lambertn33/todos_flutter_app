import 'package:flutter/material.dart';
import 'package:todos_http_app/screens/reusable/drawer.dart';
import 'package:todos_http_app/screens/todos/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateToListPage() {
    final indexTodosRoute =
        MaterialPageRoute(builder: (context) => const TodoList());
    Navigator.of(context).push(indexTodosRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos App'), centerTitle: true,),
      drawer: mainDrawer(context),
    );
  }
}

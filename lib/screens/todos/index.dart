import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todos_http_app/helpers/constants.dart';
import 'package:todos_http_app/models/todo_model.dart';
import 'package:todos_http_app/screens/todos/create.dart';
import 'package:todos_http_app/screens/todos/edit.dart';
import 'package:todos_http_app/services/todos_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool isLoading = true;
  List<Todo> initialTodos = [];

  //initially fetch todos
  Future<void> getTodos() async {
    List<Todo> todos = [];
    http.Response response = await TodoServices().getTodos(20);
    if (response.statusCode == Constants.httpResponseIndexStatus) {
      final fetchedResponse = jsonDecode(response.body);
      final fetchedTodos = fetchedResponse['items'];
      for (var fetchedTodo in fetchedTodos) {
        Todo todo = Todo(
          id: fetchedTodo['_id'],
          title: fetchedTodo['title'],
          description: fetchedTodo['description'],
          isCompleted: fetchedTodo['is_completed'],
        );
        todos.add(todo);
      }
    }
    setState(() {
      initialTodos = todos;
      isLoading = false;
    });
  }

  // delete todo
  Future<void> deleteTodo(todoId) async {
    http.Response response = await TodoServices().deleteTodo(todoId);
    if (response.statusCode == Constants.httpResponseIndexStatus) {
      final updatedTodos =
          initialTodos.where((element) => element.id != todoId).toList();

      setState(() {
        initialTodos = updatedTodos;
      });
      showSnackBar('Todo delete successfully', Colors.green.shade900);
    } else {
      showSnackBar('Error... please try again', Colors.red.shade900);
    }
  }

  // show success/error message
  void showSnackBar(String message, Color color) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //navigate to create page
  Future<void> navigateToAddTodoPage() async {
    final addTodoRoute =
        MaterialPageRoute(builder: (context) => const CreateTodo());
    await Navigator.of(context).push(addTodoRoute);
    setState(() {
      isLoading = true;
    });
    getTodos();
  }

  //navigate to edit page
  Future<void> navigateToEditTodoPage(todo) async {
    final editTodoRoute =
        MaterialPageRoute(builder: (context) => EditTodo(todo: todo));
    await Navigator.of(context).push(editTodoRoute);
    setState(() {
      isLoading = true;
    });
    getTodos();
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(Constants.indexAppTitle),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getTodos();
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: !isLoading
              ? (initialTodos.isNotEmpty
                  ? ListView.builder(
                      itemCount: initialTodos.length,
                      itemBuilder: (context, index) {
                        Todo todo = initialTodos[index];
                        return todoWidget(todo, index);
                      },
                    )
                  : emptyDataWidget())
              : const Center(
                  child: SpinKitCubeGrid(
                    color: Colors.white,
                    size: 30,
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddTodoPage,
        label: Text(Constants.createAppTitle),
      ),
    );
  }

  Card todoWidget(Todo todo, int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${index + 1}', textAlign: TextAlign.center),
        ),
        trailing: PopupMenuButton(onSelected: (value) {
          if (value == 'delete') {
            deleteTodo(todo.id);
          }
          else if (value == 'edit') {
            navigateToEditTodoPage(todo);
          }
        }, itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: 'view',
              child: Text('View'),
            ),
            const PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ];
        }),
        title: Text(
          todo.title,
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            todo.isCompleted ? 'Completed' : 'Pending',
            style: TextStyle(
                color: todo.isCompleted
                    ? Colors.green.shade900
                    : Colors.red.shade900,
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
        ),
      ),
    );
  }

  Center errorWidget() {
    return Center(
      child: Column(
        children: [
          const Text('an error occured.. please try again',
              style: TextStyle(fontSize: 20)),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Fetch again'),
          ),
        ],
      ),
    );
  }

  Center emptyDataWidget() {
    return const Center(
      child: Text(
        'Todo list is empty',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

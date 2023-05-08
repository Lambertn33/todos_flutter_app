import 'package:flutter/material.dart';
import 'package:todos_http_app/helpers/constants.dart';
import 'package:todos_http_app/models/todo_model.dart';
import 'package:todos_http_app/screens/todos/create.dart';
import 'package:todos_http_app/services/todos_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  //initially fetch todos
  Future<List<Todo>> getTodos() async {
    List<Todo> todos = await TodoServices().getTodos();
    return todos;
  }

  //navigate to create page
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
      body: FutureBuilder(
          future: getTodos(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return errorWidget();
            } else if (!snapshot.hasData) {
              return const Center(
                child: SpinKitWave(
                  color: Colors.white,
                  size: 30,
                ),
              );
            } else {
              List<Todo> todos = snapshot.data!;
              if (todos.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      Todo todo = todos[index];
                      return todoWidget(todo);
                    },
                  ),
                );
              } else {
                return emptyDataWidget();
              }
            }
          })),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddTodoPage,
        label: Text(Constants.createAppTitle),
      ),
    );
  }
}

Card todoWidget(Todo todo) {
  return Card(
    child: Padding(
    padding: const EdgeInsets.all(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              todo.title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Container(
            width: 80,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(left: 16, bottom: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: !todo.isCompleted ? Colors.red.shade800 : Colors.green.shade800,
            ),
            child: Text(todo.isCompleted ? 'Completed' : 'Pending'),
          )
        ],
      ),
    ),
  );
}

Center errorWidget() {
  return Center(
    child: Column(
      children: [
        const Text('an error occured.. please try again'),
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
    child: Text('Todo list is empty'),
  );
}

import 'package:flutter/material.dart';
import 'package:todos_http_app/helpers/constants.dart';
import 'package:todos_http_app/services/todos_services.dart';
import 'package:http/http.dart' as http;

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

enum TodoStatus { pending, completed }

class _CreateTodoState extends State<CreateTodo> {
  TodoStatus todoStatus = TodoStatus.pending;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> createTodo() async {
    final title = titleController.text;
    final description = descriptionController.text;
    late bool status;

    if (todoStatus == TodoStatus.completed) {
      status = true;
    } else {
      status = false;
    }

    final createdTodo = {
      "title": title,
      "description": description,
      "is_completed": status
    };

    http.Response response = await TodoServices().createTodo(createdTodo);
    if (response.statusCode == Constants.httpResponseCreateStatus) {
      titleController.text = '';
      descriptionController.text = '';
      showSnackBar('Todo created successfully.', Colors.green.shade800);
    } else {
      showSnackBar('error.. please retry', Colors.red.shade800);
    }
  }

  void showSnackBar(String message, Color color) {
    final snackBar = SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(Constants.createAppTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "title",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText: "description",
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  const Text(
                    'Select Todo status',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ListTile(
                    title: const Text('Pending'),
                    leading: Radio<TodoStatus>(
                      value: TodoStatus.pending,
                      groupValue: todoStatus,
                      onChanged: (TodoStatus? value) {
                        setState(() {
                          todoStatus = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Completed'),
                    leading: Radio<TodoStatus>(
                      value: TodoStatus.completed,
                      groupValue: todoStatus,
                      onChanged: (TodoStatus? value) {
                        setState(() {
                          todoStatus = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: createTodo,
                child: Text(Constants.createAppTitle),
              )
            ],
          ),
        ),
      ),
    );
  }
}

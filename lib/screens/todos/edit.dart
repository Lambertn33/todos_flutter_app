// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todos_http_app/helpers/constants.dart';
import 'package:todos_http_app/models/todo_model.dart';
import 'package:todos_http_app/screens/reusable/drawer.dart';
import 'package:todos_http_app/screens/reusable/snackbar.dart';
import 'package:todos_http_app/services/todos_services.dart';
import 'package:http/http.dart' as http;

class EditTodo extends StatefulWidget {
  final Todo todo;
  const EditTodo({required this.todo, super.key});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

enum TodoStatus { pending, completed }

class _EditTodoState extends State<EditTodo> {
  late TodoStatus todoStatus;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final Todo todoToEdit = widget.todo;
    todoStatus =
        widget.todo.isCompleted ? TodoStatus.completed : TodoStatus.pending;
    titleController.text = todoToEdit.title;
    descriptionController.text = todoToEdit.description;
  }

  Future<void> editTodo() async {
    final todoId = widget.todo.id;
    final title = titleController.text;
    final description = descriptionController.text;
    late bool status;

    if (todoStatus == TodoStatus.completed) {
      status = true;
    } else {
      status = false;
    }

    final editedTodo = {
      "title": title,
      "description": description,
      "is_completed": status
    };

    http.Response response = await TodoServices.editTodo(todoId, editedTodo);
    if (response.statusCode == Constants.httpResponseIndexStatus) {
      showSnackBar(context, 'Todo updated successfully.', Colors.green.shade800);
    } else {
      showSnackBar(context, 'error.. please retry', Colors.red.shade800);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(Constants.editAppTitle),
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
                onPressed: editTodo,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(Constants.editAppTitle),
              )
            ],
          ),
        ),
      ),
    );
  }
}

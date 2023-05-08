import 'package:flutter/material.dart';
import 'package:todos_http_app/helpers/constants.dart';
import 'package:todos_http_app/models/todo_model.dart';
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
    todoStatus = widget.todo.isCompleted ? TodoStatus.completed : TodoStatus.pending;
    titleController.text = todoToEdit.title;
    descriptionController.text = todoToEdit.description;
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
                onPressed: () {},
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

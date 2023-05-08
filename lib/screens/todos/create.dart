import 'package:flutter/material.dart';
import 'package:todos_http_app/helpers/constants.dart';
import 'package:todos_http_app/services/todos_services.dart';
import 'package:http/http.dart' as http;

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> createTodo() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final createdTodo = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    http.Response response = await TodoServices().createTodo(createdTodo);
    if (response.statusCode == Constants.httpResponseCreateStatus) {
      print('success.. todo created');
    } else {
      print(' error... todo not created');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(Constants.createAppTitle),
      ),
      body: Padding(
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
              height: 12,
            ),
            ElevatedButton(
              onPressed: createTodo,
              child: Text(Constants.createAppTitle),
            )
          ],
        ),
      ),
    );
  }
}

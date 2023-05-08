import 'package:flutter/material.dart';
import 'package:todos_http_app/helpers/constants.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "title",
              ),
            ),
            const SizedBox(height: 16,),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "description",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(Constants.createAppTitle),
            )
          ],
        ),
      ),
    );
  }
}

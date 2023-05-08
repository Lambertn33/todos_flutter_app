import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todos_http_app/helpers/constants.dart';
import 'package:todos_http_app/models/todo_model.dart';

class TodoServices {
  //list todos
  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    http.Response response = await http.get(Uri.parse(Constants.url));
    if (response.statusCode == 200) {
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
    return todos;
  }

  //create todo
  Future createTodo(newTodo) async {
    http.Response response = await http.post(Uri.parse(Constants.url),
        body: jsonEncode(newTodo), headers: Constants.httpCreateHeaders);
    return response;
  }
}

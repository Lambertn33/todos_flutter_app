import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todos_http_app/helpers/constants.dart';

class TodoServices {
  //list todos
  Future getTodos(int limit) async {
    http.Response response =
        await http.get(Uri.parse('${Constants.url}?page=1&limit=$limit'));
    return response;
  }

  //create todo
  Future createTodo(newTodo) async {
    http.Response response = await http.post(Uri.parse(Constants.url),
        body: jsonEncode(newTodo), headers: Constants.httpHeaders);
    return response;
  }

  Future editTodo(todoId, editedTodo) async {
    http.Response response = await http.put(Uri.parse('${Constants.url}/$todoId'),
        body: jsonEncode(editedTodo), headers: Constants.httpHeaders);
    return response;
  }

  //delete todo
  Future deleteTodo(todoId) async {
    http.Response response = await http.delete(Uri.parse('${Constants.url}/$todoId'));
    return response;
  }
}

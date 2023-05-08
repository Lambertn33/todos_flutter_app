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
        body: jsonEncode(newTodo), headers: Constants.httpCreateHeaders);
    return response;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todos_http_app/helpers/constants.dart';

class TodoServices {
  Future createTodo(newTodo) async {
    http.Response response = await http.post(Uri.parse(Constants.url),
        body: jsonEncode(newTodo), headers: Constants.httpCreateHeaders);
    return response;
  }
}

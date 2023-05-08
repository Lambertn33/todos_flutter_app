import 'package:flutter/material.dart';
import 'package:todos_http_app/helpers/constants.dart';
import 'package:todos_http_app/screens/home/homepage.dart';
import 'package:todos_http_app/screens/todos/index.dart';

Drawer mainDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        image: DecorationImage(
                            image:
                                AssetImage('${Constants.imagesUrl}/user.png'))),
                  ),
                  Column(
                    children: const [
                      Text(
                        'User Names',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text('user@gmail.com'),
                      Text('KIGALI-RWANDA'),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                },
                title: const Text('Home'),
                leading: const Icon(Icons.home),
                trailing: const Icon(Icons.arrow_forward),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TodoList()));
                },
                title: const Text('Todo List'),
                leading: const Icon(Icons.list),
                trailing: const Icon(Icons.arrow_forward),
              ),
              const Divider(),
            ],
          ),
        ),
      ],
    ),
  );
}

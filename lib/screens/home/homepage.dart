import 'package:flutter/material.dart';
import 'package:todos_http_app/helpers/constants.dart';
import 'package:todos_http_app/screens/reusable/drawer.dart';
import 'package:todos_http_app/screens/todos/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateToListPage() {
    final indexTodosRoute =
        MaterialPageRoute(builder: (context) => const TodoList());
    Navigator.of(context).push(indexTodosRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todos App'),
          centerTitle: true,
        ),
        drawer: mainDrawer(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys'
                  'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a'
                  'type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining'
                  'essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more',
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'About us',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys'
                    'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a'
                    'type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining'
                    'essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more'),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Recent Pictures',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            height: 350,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(image: AssetImage('${Constants.imagesUrl}/fashion_3.jpg'), fit: BoxFit.cover)
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            height: 350,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(image: AssetImage('${Constants.imagesUrl}/fashion_5.jpg'), fit: BoxFit.cover)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12,),
                const Text(
                  'Contact us',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 12,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: const [
                          Text('lamb@gmail.com'),
                          SizedBox(height: 4,),
                          Text('+250700000000')
                        ],
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.home),
                          Icon(Icons.zoom_in),
                          Icon(Icons.add_alert),
                          Icon(Icons.adjust_rounded),
                          Icon(Icons.wifi_tethering),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

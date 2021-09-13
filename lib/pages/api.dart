import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> fetchSomeThing() async {
  final response =
      await http.get(Uri.parse('https://hs.hellozwz.com/hot-searches'));
  return response.body;
}

class ApiPage extends StatefulWidget {
  ApiPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  Future<String> futureSome;

  @override
  void initState() {
    futureSome = fetchSomeThing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<String>(
              future: futureSome,
              builder: (context, snapshot) {
                return Text(snapshot.data.toString());
              },
            )
          ],
        ),
      ),
    );

    throw UnimplementedError();
  }
}

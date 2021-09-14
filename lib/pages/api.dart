import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:map/src/model/hot_search.dart';

Future<HotSearch> fetchHotSearch() async {
  final response =
      await http.get(Uri.parse('https://hs.hellozwz.com/hot-searches'));
  if (response.statusCode == 200) {
    return HotSearch.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load HotSearch');
  }
}

class ApiPage extends StatefulWidget {
  ApiPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  Future<HotSearch> hotSearch;

  @override
  void initState() {
    hotSearch = fetchHotSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
      ),
      body: Center(
        child: FutureBuilder<HotSearch>(
          future: hotSearch,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data;
              var time = data.time;
              var image = data.imageFile;
              var pdf = data.pdfFile;
              var searches = data.searches;
              return Column(
                children: <Widget>[
                  Text(time),
                  Text(image),
                  Text(pdf),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searches.length,
                      itemBuilder: (context, int index) {
                        return Column(
                          children: [
                            Text(searches[index].topicLead),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('{$snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

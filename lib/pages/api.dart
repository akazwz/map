import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:map/src/model/hot_search.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                        return ShowSearch(
                            rank: searches[index].rank,
                            content: searches[index].content,
                            hot: searches[index].hot,
                            topicLead: searches[index].topicLead,
                            onPress: () {
                              Fluttertoast.showToast(
                                  msg: searches[index].content);
                            });
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

class ShowSearch extends StatelessWidget {
  ShowSearch({
    @required this.rank,
    @required this.content,
    @required this.hot,
    @required this.topicLead,
    @required this.onPress,
  });

  final int rank;
  final String content;
  final int hot;
  final String topicLead;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(rank.toString() + " : " + hot.toString()),
          TextButton(onPressed: this.onPress, child: Text(content)),
          Text(topicLead),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map/src/model/hot_search.dart';
import 'package:url_launcher/url_launcher.dart';
import '../http.dart';

Future<HotSearch> fetchHotSearch() async {
  final response = await dio.get('https://hs.hellozwz.com/hot-searches');
  if (response.statusCode == 200) {
    return HotSearch.fromJson(response.data);
  } else {
    throw Exception('Failed to load HotSearch');
  }
}

class ApiPage extends StatefulWidget {
  ApiPage({required this.title}) : super();
  final String title;

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  late Future<HotSearch> hotSearch;

  @override
  void initState() {
    // TODO: implement initState
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
              var data = snapshot.data!.data;
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
                            Navigator.of(context).pushNamed('/chart',
                                arguments: {
                                  'content': searches[index].content
                                });
                          },
                          onLongPress: () async {
                            var _url = 'sinaweibo://searchall?q=' +
                                searches[index].content;
                            await canLaunch(_url)
                                ? await launch(_url)
                                : Fluttertoast.showToast(msg: "暂时不能跳转");
                          },
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

class ShowSearch extends StatelessWidget {
  ShowSearch({
    required this.rank,
    required this.content,
    required this.hot,
    required this.topicLead,
    required this.onPress,
    required this.onLongPress,
  });

  final int rank;
  final String content;
  final int hot;
  final String topicLead;
  final void Function() onPress;
  final void Function() onLongPress;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(rank.toString() + " : " + hot.toString()),
          TextButton(
            onPressed: this.onPress,
            child: Text(content),
            onLongPress: this.onLongPress,
          ),
          Text(topicLead),
        ],
      ),
    );
  }
}

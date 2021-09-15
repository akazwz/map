import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:map/http.dart';
import 'package:map/src/model/hot_search.dart';

class DioTest extends StatefulWidget {
  @override
  _DioTestState createState() => _DioTestState();
}

class _DioTestState extends State<DioTest> {
  String _time = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Text(_time),
          ElevatedButton(
            onPressed: () async {
              await dio.get('https://hs.hellozwz.com/hot-searches').then((r) {
                var hotSearch = HotSearch.fromJson(r.data);
                setState(() {
                  _time = hotSearch.data.time;
                });
              });
            },
            child: Text("Get Time"),
          ),
        ],
      ),
    );

    throw UnimplementedError();
  }
}

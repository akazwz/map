import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map/pages/api.dart';
import 'package:map/pages/chart.dart';
import 'package:map/pages/dio_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'http.dart'; // make dio as global top-level variable
import './pages/map.dart';

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void main() {
  dio.interceptors.add(LogInterceptor());
  dio.options.receiveTimeout = 15000;
  (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home'),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) =>
            MyHomePage(title: 'Flutter Demo Home Page'),
        '/map': (BuildContext context) => MapPage(title: 'Map Page'),
        '/api': (BuildContext context) => ApiPage(title: 'Api'),
        '/chart': (BuildContext context) => Chart(),
        '/dio-test': (BuildContext context) => DioTest(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title}) : super();

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _reductionCounter() {
    setState(() {
      _counter--;
    });
  }

  void _navigateToMap() {
    Navigator.of(context).pushNamed('/map');
  }

  void _navigateToApi() {
    Navigator.of(context).pushNamed('/api');
  }

  void _navigateToChart() {
    Navigator.of(context).pushNamed('/chart');
  }

  void _call() async {
    const _url = 'tel:+8615153953308';
    await canLaunch(_url)
        ? await launch(_url)
        : Fluttertoast.showToast(msg: "??????????????????");
  }

  void _goToWeibo() async {
    /**
     * ????????????
     * sinaweibo://gotohome
     * hotsearch
     * ????????????
     * sinaweibo://share?content=[???????????? URL Encode]
     * ????????????
     * sinaweibo://discover
     * ????????????
     * sinaweibo://searchall?q=[URL Encode]
     * ???????????????
     * sinaweibo://qrcode
     * ???????????????
     * sinaweibo://detail?mblogid=[mblogid]
     * ???????????????????????????
     * sinaweibo://cardlist?containerid=[containerid]
     * ?????????????????????
     * sinaweibo://messagelist?uid=[uid]
     * ?????????????????????
     * sinaweibo://userinfo?uid=[uid]
     */
    const _url = 'sinaweibo://gotohome';
    await canLaunch(_url)
        ? await launch(_url)
        : Fluttertoast.showToast(msg: "??????????????????");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have clicked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
                onPressed: _reductionCounter, child: const Text('Reduction')),
            TextButton(
                onPressed: _incrementCounter, child: const Text('Increment')),
            TextButton(
                onPressed: _navigateToMap, child: const Text('Go To Map')),
            TextButton(
                onPressed: _navigateToApi, child: const Text('Go To Api')),
            TextButton(
                onPressed: _navigateToChart, child: const Text('Go To Chart')),
            TextButton(onPressed: _call, child: const Text('Call')),
            TextButton(onPressed: _goToWeibo, child: const Text('weibo')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/dio-test');
                },
                child: const Text('dio')),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:map/pages/api.dart';
import 'package:map/pages/chart.dart';
import './pages/map.dart';

void main() {
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
          ],
        ),
      ),
    );
  }
}

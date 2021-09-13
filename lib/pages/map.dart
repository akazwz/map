import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
        width: 20.0,
        height: 20.0,
        point: LatLng(77.855, -62.09),
        builder: (ctx) => Container(
          child: FlutterLogo(
            textColor: Colors.blue,
            key: ObjectKey(Colors.blue),
          ),
        ),
      ),
      Marker(
        width: 20.0,
        height: 20.0,
        point: LatLng(75.455, 2.59),
        builder: (ctx) => Container(
          child: FlutterLogo(
            textColor: Colors.blue,
            key: ObjectKey(Colors.blue),
          ),
        ),
      ),
      Marker(
        width: 20.0,
        height: 20.0,
        point: LatLng(76.255, -136.59),
        builder: (ctx) => Container(
          child: FlutterLogo(
            textColor: Colors.blue,
            key: ObjectKey(Colors.blue),
          ),
        ),
      ),
      Marker(
        width: 20.0,
        height: 20.0,
        point: LatLng(24.555, -16.09),
        builder: (ctx) => Container(
          child: FlutterLogo(
            textColor: Colors.blue,
            key: ObjectKey(Colors.blue),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Column(
        children: [
          Flexible(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(70.505, -75.09),
                zoom: 2,
                maxZoom: 6,
                minZoom: 2,
                bounds: LatLngBounds(LatLng(85.455, 38), LatLng(0, -176.59)),
                boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://map.hellozwz.com/public/images/tiles/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: markers,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

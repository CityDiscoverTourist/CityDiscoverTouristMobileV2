import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ManyMarkersPage extends StatefulWidget {
  static const String route = '/many_markers';

  const ManyMarkersPage({Key? key}) : super(key: key);

  @override
  _ManyMarkersPageState createState() => _ManyMarkersPageState();
}

class _ManyMarkersPageState extends State<ManyMarkersPage> {
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  List<Marker> allMarkers = [];

  // int _sliderVal = maxMarkersCount ~/ 10;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      allMarkers.add(
        Marker(
          point: LatLng(10.845362657418587, 106.79410016682986),
          builder: (context) => const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 30.0,
          ),
        ),
      );
      allMarkers.add(
        Marker(
          point: LatLng(10.844709350072248, 106.7858282343411),
          builder: (context) => const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 30.0,
          ),
        ),
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A lot of markers')),
      // drawer: buildDrawer(context, ManyMarkersPage.route),
      body: Column(
        children: [
          // Slider(
          //   min: 0,
          //   max: maxMarkersCount.toDouble(),
          //   divisions: maxMarkersCount ~/ 500,
          //   label: 'Markers',
          //   value: _sliderVal.toDouble(),
          //   onChanged: (newVal) {
          //     _sliderVal = newVal.toInt();
          //     setState(() {});
          //   },
          // ),
          // Text('$_sliderVal markers'),
          Flexible(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(10.845362657418587, 106.79410016682986),
                zoom: 17.0,
                interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(markers: allMarkers),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

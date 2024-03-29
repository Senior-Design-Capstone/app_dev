// import 'package:intl/intl.dart';

// import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'data-retrieval.dart';

import 'dart:async';

import 'marker-icon-generator.dart';

class GliderList {
  static final GliderList _instance = GliderList._internal();
  factory GliderList() => _instance;

  GliderList._internal() {
    _list = SLAPI.fetchGliders();
    _timeOfLastRefresh = DateTime.now();
    _colors = [
      Colors.red,
      Colors.blue,
      Colors.cyan,
      Colors.green,
      Colors.pink,
      Colors.teal,
      Colors.purple,
      Colors.grey,
      Colors.amber,
      Colors.black
    ];
    updateMarkerList();
    updatePolylineList();
  }

  late Future<List<dynamic>> _list;
  late DateTime _timeOfLastRefresh;
  late DateTime _timeCurrent;
  late List<Color> _colors;
  late Set<Marker> _markers = Set<Marker>();
  late Set<Polyline> _polylines = Set<Polyline>();

  Future<List<dynamic>> get list => _list;
  DateTime get timeOfLastRefresh => _timeOfLastRefresh;
  DateTime get timeCurrent => _timeCurrent;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polylines => _polylines;
  List<Color> get colors => _colors;
  // set list(Future<List<dynamic>> value) => list=value;
  void updateList() {
    _list = SLAPI.fetchGliders();
    _timeOfLastRefresh = DateTime.now();
    updateMarkerList();
    updatePolylineList();
    print("Updated");
  }

  void updateTime() {
    _timeCurrent = DateTime.now();
  }

  void updateMarkerList() async {
    _markers = Set<Marker>();
    List<dynamic> test = await _list;
    for (var i = 0; i < test.length; i++) {
      double lat = double.parse(SLAPI.getGliderLat(test[i]));
      double lon = double.parse(SLAPI.getGliderLon(test[i]));
      _markers.add(
        Marker(
          markerId: MarkerId(SLAPI.getGliderId(test[i])),
          infoWindow: InfoWindow(title: SLAPI.getGliderName(test[i])),
          position: LatLng(lat, lon),
          visible: true,
          icon: await MarkerGenerator.createBitmapDescriptorFromIconData(
              _colors[i % 10]),
        ),
      );
    }
    // print(_markers);
  }

  void updatePolylineList() async {
    print("test, updating polylines");
    _polylines = Set<Polyline>();
    List<dynamic> test = await _list;
    String deploymentName;
    List<dynamic> lineString;
    List<LatLng> latlng;
    for (var i = 0; i < test.length; i++) {
      latlng = [];
      deploymentName = SLAPI.getDeploymentName(test[i]);
      lineString = await SLAPI.getLineString(deploymentName);
      for (var j = 0; j < lineString.length; j++) {
        // print("length:"+lineString.length.toString());
        print("(" +
            lineString[j][0].toString() +
            "," +
            lineString[j][1].toString() +
            ")");
        latlng.add(LatLng(lineString[j][1], lineString[j][0]));
      }
      _polylines.add(
        Polyline(
          polylineId: PolylineId(SLAPI.getGliderId(test[i]) + "1"),
          points: latlng,
          color: _colors[i % 10],
          width: 1,
          visible: true,
        ),
      );
      print(_polylines);
    }
  }
}

// import 'package:intl/intl.dart';

// import 'dart:collection';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'data-retrieval.dart';

import 'dart:async';

class GliderList {
  static final GliderList _instance = GliderList._internal();
  factory GliderList() => _instance;

  GliderList._internal() {
    _list = SLAPI.fetchGliders();
    _timeOfLastRefresh = DateTime.now();
    updateMarkerList();
  }

  late Future<List<dynamic>> _list;
  late DateTime _timeOfLastRefresh;
  late DateTime _timeCurrent;
  late Set<Marker> _markers = Set<Marker>();

  Future<List<dynamic>> get list => _list;
  DateTime get timeOfLastRefresh => _timeOfLastRefresh;
  DateTime get timeCurrent => _timeCurrent;
  Set<Marker> get markers => _markers;
  // set list(Future<List<dynamic>> value) => list=value;
  void updateList() {
    _list = SLAPI.fetchGliders();
    _timeOfLastRefresh = DateTime.now();
    updateMarkerList();
    print("Updated");
  }

  void updateTime() {
    _timeCurrent = DateTime.now();
  }

  void updateMarkerList() async{
    _markers = Set<Marker>();
    List<dynamic> test = await _list;
    for(var i=0;i<test.length;i++){
      double lat = double.parse(SLAPI.getGliderLat(test[i]));
      double lon = double.parse(SLAPI.getGliderLon(test[i]));
      _markers.add(
        Marker(
          markerId: MarkerId(SLAPI.getGliderId(test[i])),
          position: LatLng(lat,lon),
        ),
      );
    }
    // print(_markers);
  }
}

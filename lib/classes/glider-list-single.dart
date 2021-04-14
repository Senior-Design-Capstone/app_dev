import 'package:intl/intl.dart';

import 'data-retrieval.dart';

class GliderList {
  static final GliderList _instance = GliderList._internal();
  factory GliderList() => _instance;

  GliderList._internal() {
    _list = SLAPI.fetchGliders();
    _timeOfLastRefresh = DateTime.now();
  }

  late Future<List<dynamic>> _list;
  late DateTime _timeOfLastRefresh;
  late DateTime _timeCurrent;

  Future<List<dynamic>> get list => _list;
  DateTime get timeOfLastRefresh => _timeOfLastRefresh;
  DateTime get timeCurrent => _timeCurrent;
  // set list(Future<List<dynamic>> value) => list=value;
  void updateList() {
    _list = SLAPI.fetchGliders();
    _timeOfLastRefresh = DateTime.now();
    print("Updated");
  }

  void updateTime() {
    _timeCurrent = DateTime.now();
  }
}

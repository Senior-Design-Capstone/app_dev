import 'data-retrieval.dart';

class GliderList{
  static final GliderList _instance = GliderList._internal();
  factory GliderList() => _instance;
  GliderList._internal() {
    _list=SLAPI.fetchGliders();
  }

  late Future<List<dynamic>> _list;

  Future<List<dynamic>> get list => _list;
  // set list(Future<List<dynamic>> value) => list=value;
  void updateList(){
    _list=SLAPI.fetchGliders();
    print("Updated");
  } 
}
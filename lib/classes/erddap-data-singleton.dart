import 'data-retrieval.dart';
import 'glider-list-single.dart';

class ErddapDataList{
  static final ErddapDataList _instance = ErddapDataList._internal();
  factory ErddapDataList() => _instance;

  ErddapDataList._internal() {
    _dataList = [];
  }
  
  late List<Future<List<dynamic>>> _dataList;

  List<Future<List<dynamic>>> get dataList => _dataList;

  void updateList() async{
    _dataList = [];
    GliderList _gliderList = GliderList();
    List<dynamic> gliderList = await _gliderList.list;
    for(var i=0;i<gliderList.length;i++){
      _dataList.add(Erddap.fetchData(SLAPI.getDeploymentName(gliderList[i])));
    }
  }
}
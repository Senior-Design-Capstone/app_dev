import 'data-retrieval.dart';
import 'glider-list-single.dart';

class ErddapDataList{
  static final ErddapDataList _instance = ErddapDataList._internal();
  factory ErddapDataList() => _instance;

  ErddapDataList._internal() {
    _dataListMap = Map();
  }
  
  late Map<String,Future<List<dynamic>>> _dataListMap;

  Map<String,Future<List<dynamic>>> get dataListMap => _dataListMap;

  void updateList() async{
    // _dataListMap.clear();
    GliderList _gliderList = GliderList();
    List<dynamic> gliderList = await _gliderList.list;
    List<MapEntry<String,Future<List<dynamic>>>> entries = [];
    for(var i=0;i<gliderList.length;i++){
      String deploymentName = SLAPI.getDeploymentName(gliderList[i]);
      MapEntry<String,Future<List<dynamic>>> toAdd = MapEntry(deploymentName,Erddap.fetchData(deploymentName));
      entries.add(toAdd);
    }
    _dataListMap = Map.fromEntries(entries);
  }
}
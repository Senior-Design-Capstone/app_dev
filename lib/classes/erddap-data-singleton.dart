import 'data-retrieval.dart';
import 'glider-list-single.dart';

class ErddapDataList{
  static final ErddapDataList _instance = ErddapDataList._internal();
  factory ErddapDataList() => _instance;

  ErddapDataList._internal() {
    // _columnNameMap = Map<String,Future<List<dynamic>>>();
    // _columnTypeMap = Map<String,Future<List<dynamic>>>();
    // _columnUnitMap = Map<String,Future<List<dynamic>>>();
    _dataMap = Map<String,Future<List<dynamic>>>();
  }
  
  // late Map<String,Future<Map<String,dynamic>>> _dataListMap;
  // late Map<String,Future<List<dynamic>>> _columnNameMap;
  // late Map<String,Future<List<dynamic>>> _columnTypeMap;
  // late Map<String,Future<List<dynamic>>> _columnUnitMap;
  late Map<String,Future<List<dynamic>>> _dataMap;

  // Map<String,Future<List<dynamic>>> get columnNameMap => _columnNameMap;
  // Map<String,Future<List<dynamic>>> get columnTypeMap => _columnTypeMap;
  // Map<String,Future<List<dynamic>>> get columnUnitMap => _columnUnitMap;
  Map<String,Future<List<dynamic>>> get dataMap => _dataMap;

  void updateMap() async{
    // _dataListMap.clear();
    print("starting updating ERDDAP data map");
    GliderList _gliderList = GliderList();
    List<dynamic> gliderList = await _gliderList.list;
    // List<MapEntry<String,Future<List<dynamic>>>> entries1 = [];
    // List<MapEntry<String,Future<List<dynamic>>>> entries2 = [];
    // List<MapEntry<String,Future<List<dynamic>>>> entries3 = [];
    List<MapEntry<String,Future<List<dynamic>>>> entries4 = [];
    for(var i=0;i<gliderList.length;i++){
      String deploymentName = SLAPI.getDeploymentName(gliderList[i]);
      // MapEntry<String,Future<List<dynamic>>> toAdd1 = MapEntry(deploymentName,json.decode(result.body)['table']['columnNames']);
      // MapEntry<String,Future<List<dynamic>>> toAdd2 = MapEntry(deploymentName,json.decode(result.body)['table']['columnTypes']);
      // MapEntry<String,Future<List<dynamic>>> toAdd3 = MapEntry(deploymentName,json.decode(result.body)['table']['columnUnits']);
      MapEntry<String,Future<List<dynamic>>> toAdd4 = MapEntry(deploymentName,Erddap.fetchData(deploymentName));
      // entries1.add(toAdd1);
      // entries2.add(toAdd2);
      // entries3.add(toAdd3);
      entries4.add(toAdd4);
    }
    // _columnNameMap = Map.fromEntries(entries1);
    // _columnTypeMap = Map.fromEntries(entries2);
    // _columnUnitMap = Map.fromEntries(entries3);
    _dataMap = Map.fromEntries(entries4);
    print("updated Erddap data maps");
  }
}
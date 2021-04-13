// ignore: import_of_legacy_library_into_null_safe
import 'package:charts_flutter/flutter.dart' as charts;
import 'data-retrieval.dart';

class TimeData{
  final DateTime date;
  final double value;

  TimeData(this.date, this.value);

  // Create YO series with yoData from endpoint, and data starting from point specified (12 = 12 hours before, 1 = 1 day before, 7 = 7 days before)
  static List<charts.Series<TimeData, DateTime>> buildYODataList(List<dynamic> apiData,int before) {
    print("Starting parse process...");
    if(before==1){
      
    }
    List<TimeData> yoData = [];
    List<dynamic> columnNames = Erddap.getColumnNames(apiData);
    List<dynamic> data = Erddap.getData(apiData);
    int timeInd = columnNames.indexOf('time');
    int depthInd = columnNames.indexOf('depth');

    for(var i=0;i<data.length;i++){
      if(data[i][depthInd].toString()!='null'){
        yoData.add(new TimeData(DateTime.parse(data[i][timeInd]), -data[i][depthInd]));
      }
    }
    print("Done parse process...");
    return [
      new charts.Series<TimeData, DateTime>(
        id: 'TimeData',
        domainFn: (TimeData tdata, _) => tdata.date,
        measureFn: (TimeData tdata, _) => tdata.value,
        data: yoData,
      )
    ];
  }
}
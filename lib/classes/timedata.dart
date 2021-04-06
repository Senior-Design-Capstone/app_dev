// ignore: import_of_legacy_library_into_null_safe
import 'package:charts_flutter/flutter.dart' as charts;

class TimeData{
  final DateTime date;
  final double value;

  TimeData(this.date, this.value);

  // Create YO series with data from endpoint
  static List<charts.Series<TimeData, DateTime>> buildYODataList(List<dynamic> apiData) {
    print("Starting parse process...");
    List<TimeData> data = [];

    for(var i=0;i<apiData.length;i++){
      if(apiData[i][1].toString()!='null'){
        data.add(new TimeData(DateTime.parse(apiData[i][0]), -apiData[i][1]));
      }
    }
    print("Done parse process...");
    return [
      new charts.Series<TimeData, DateTime>(
        id: 'TimeData',
        domainFn: (TimeData tdata, _) => tdata.date,
        measureFn: (TimeData tdata, _) => tdata.value,
        data: data,
      )
    ];
  }
}
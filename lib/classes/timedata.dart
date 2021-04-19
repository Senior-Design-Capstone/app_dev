// ignore: import_of_legacy_library_into_null_safe
import 'package:charts_flutter/flutter.dart' as charts;

class TimeData{
  final DateTime date;
  final double value;

  TimeData(this.date, this.value);

  // Create YO series with yoData from endpoint, and data starting from point specified (12 = 12 hours before, 1 = 1 day before, 7 = 7 days before)
  static List<charts.Series<TimeData, DateTime>> buildYODataList(List<dynamic> apiData,int before) {
    print("Starting parse process...");
    DateTime current = DateTime.now();
    DateTime start;
    int msecs;
    //create the start time to grab all data after a specified point
    if(before==1){
      msecs = 1*24*60*60*1000;
      start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
    }
    else if(before==12){
      msecs = 1*12*60*60*1000;
      start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
    }
    else{
      msecs = 7*24*60*60*1000;
      start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
    }
    List<TimeData> yoData = [];

    for(var i=0;i<apiData.length;i++){
      if(apiData[i][1].toString()!='null'){
        DateTime dataTime = DateTime.parse(apiData[i][0]);
        if(dataTime.isAfter(start)){
          yoData.add(new TimeData(dataTime, -apiData[i][1].toDouble()));
        }
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

  //
  static List<charts.Series<TimeData, DateTime>> buildPressureDataList(List<dynamic> apiData,int before) {
    print("Starting parse process...");
    DateTime current = DateTime.now();
    DateTime start;
    int msecs;
    //create the start time to grab all data after a specified point
    if(before==1){
      msecs = 1*24*60*60*1000;
      start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
    }
    else if(before==12){
      msecs = 1*12*60*60*1000;
      start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
    }
    else{
      msecs = 7*24*60*60*1000;
      start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
    }
    List<TimeData> pressureData = [];

    for(var i=0;i<apiData.length;i++){
      if(apiData[i][1].toString()!='null'){
        DateTime dataTime = DateTime.parse(apiData[i][0]);
        if(dataTime.isAfter(start)){
          pressureData.add(new TimeData(dataTime, -apiData[i][3].toDouble()));
        }
      }
    }
    print("Done parse process...");
    return [
      new charts.Series<TimeData, DateTime>(
        id: 'PressureData',
        domainFn: (TimeData tdata, _) => tdata.date,
        measureFn: (TimeData tdata, _) => tdata.value,
        data: pressureData,
      )
    ];
  }


  // static List<Map<String,Object>> createYoDataSetMap(List<dynamic> apiData,int before){
  //   DateTime current = DateTime.now();
  //   DateTime start;s
  //   int msecs;
  //   if(before==1){
  //     msecs = 1*24*60*60*1000;
  //     start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
  //   }
  //   else if(before==12){
  //     msecs = 1*12*60*60*1000;
  //     start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
  //   }
  //   else{
  //     msecs = 7*24*60*60*1000;
  //     start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
  //   }

  //    List<Map<String,Object>> yoData = [];
  //    for(var i=0;i<apiData.length;i++){
  //      if(apiData[i][1].toString()!='null'){
  //       DateTime dataTime = DateTime.parse(apiData[i][0]);
  //       if(dataTime.isAfter(start)){
  //         Map<String,Object> toAdd = new Map();
  //         toAdd['name'] = dataTime.toIso8601String();
  //         toAdd['value'] = -apiData[i][1];
  //         yoData.add(toAdd);
  //       }
  //     }
  //    }
  //    return yoData;
  // }

  // static List<Object> createYoDataSetDates(List<dynamic> apiData,int before){
  //   DateTime current = DateTime.now();
  //   DateTime start;
  //   int msecs;
  //   if(before==1){
  //     msecs = 1*24*60*60*1000;
  //     start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
  //   }
  //   else if(before==12){
  //     msecs = 1*12*60*60*1000;
  //     start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
  //   }
  //   else{
  //     msecs = 7*24*60*60*1000;
  //     start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
  //   }

  //    List<Object> yoDataDates = [];
  //    for(var i=0;i<apiData.length;i++){
  //      if(apiData[i][1].toString()!='null'){
  //       DateTime dataTime = DateTime.parse(apiData[i][0]);
  //       if(dataTime.isAfter(start)){
  //         yoDataDates.add(dataTime.toIso8601String());
  //       }
  //     }
  //    }
  //    return yoDataDates;
  // }

  // static List<Object> createYoDataSetValues(List<dynamic> apiData,int before){
  //   DateTime current = DateTime.now();
  //   DateTime start;
  //   int msecs;
  //   if(before==1){
  //     msecs = 1*24*60*60*1000;
  //     start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
  //   }
  //   else if(before==12){
  //     msecs = 1*12*60*60*1000;
  //     start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
  //   }
  //   else{
  //     msecs = 7*24*60*60*1000;
  //     start = DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch-msecs);
  //   }

  //    List<Object> yoDataValues = [];
  //    for(var i=0;i<apiData.length;i++){
  //      if(apiData[i][1].toString()!='null'){
  //       DateTime dataTime = DateTime.parse(apiData[i][0]);
  //       if(dataTime.isAfter(start)){
  //         yoDataValues.add(-apiData[i][1]);
  //       }
  //     }
  //    }
  //    return yoDataValues;
  // }
}
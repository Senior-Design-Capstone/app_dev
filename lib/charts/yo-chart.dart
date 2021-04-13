// ignore: import_of_legacy_library_into_null_safe
import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'dart:convert';
import '../classes/data-retrieval.dart';
import '../classes/timedata.dart';

class YoScatterPlot extends StatelessWidget {
  final String deploymentName;
  YoScatterPlot(this.deploymentName);

  // Future<List<dynamic>> fetchData() async {
  //   // print(deploymentName);
  //   // print("Fetching data...");
  //   var result = await http.get(Erddap.getRawUrlFromDeploymentName(deploymentName));
  //   // print("Data fetched!");
  //   // print(json.decode(result.body)['table']['rows']);
  //   return json.decode(result.body)['table']['rows'];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Glider YO-Plot'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: Erddap.fetchData(this.deploymentName),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return new charts.TimeSeriesChart(
                TimeData.buildYODataList(snapshot.data),
                animate: false,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                defaultRenderer: 
                  new charts.PointRendererConfig(
                    radiusPx: 1,
                    ),
                // behaviors: [new charts.PanBehavior(),],
                );
            }else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  /// Create one series with data from endpoint
  // static List<charts.Series<TimeData, DateTime>> dataList(List<dynamic> apiData) {
  //   List<TimeData> data = [];

  //   for(var i=0;i<apiData.length;i++){
  //     if(apiData[i][1].toString()!='null'){
  //       data.add(new TimeData(DateTime.parse(apiData[i][0]), -apiData[i][1]));
  //     }
  //   }
    
  //   return [
  //     new charts.Series<TimeData, DateTime>(
  //       id: 'TimeData',
  //       domainFn: (TimeData tdata, _) => tdata.date,
  //       measureFn: (TimeData tdata, _) => tdata.value,
  //       data: data,
  //     )
  //   ];
  // }
}
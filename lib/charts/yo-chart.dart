// ignore: import_of_legacy_library_into_null_safe
import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'dart:convert';
// import '../classes/data-retrieval.dart';
import '../classes/timedata.dart';
import '../classes/erddap-data-singleton.dart';

class YoScatterPlot extends StatelessWidget {
  final String deploymentName;
  final int before;
  YoScatterPlot(this.deploymentName,this.before);

  @override
  Widget build(BuildContext context) {
    ErddapDataList _erddapDataList = ErddapDataList();
    Map<String,Future<List<dynamic>>> dataMap = _erddapDataList.dataMap;
    Future<List<dynamic>> future = dataMap[this.deploymentName]!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Glider YO-Plot'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return new charts.TimeSeriesChart(
                TimeData.buildYODataList(snapshot.data,this.before),
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
}
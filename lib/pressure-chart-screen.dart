import 'package:flutter/cupertino.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:charts_flutter/flutter.dart' as charts;
import 'classes/timedata.dart';
import 'classes/erddap-data-singleton.dart';
import 'package:flutter/material.dart';
import 'yo-chart-screen.dart';

class PressureChartScreen extends StatefulWidget{
  @override
  _PressureChartScreenState createState() => _PressureChartScreenState();
}

class _PressureChartScreenState extends State<PressureChartScreen> {
  @override
  Widget build(BuildContext context){
    final GliderArguments args =
    ModalRoute.of(context)!.settings.arguments as GliderArguments;
    ErddapDataList _erddapDataList = ErddapDataList();
    Map<String,Future<List<dynamic>>> dataMap = _erddapDataList.dataMap;
    Future<List<dynamic>> future = dataMap[args.deploymentName]!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pressure vs. Time Chart'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return new charts.TimeSeriesChart(
                TimeData.buildPressureDataList(snapshot.data,args.before),
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
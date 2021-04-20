// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'classes/timedata.dart';
import 'classes/erddap-data-singleton.dart';
import 'package:flutter/material.dart';


class GliderArguments{
  final String deploymentName;
  final int before;
  GliderArguments(this.deploymentName,this.before);
}

class YoChartScreen extends StatefulWidget{
  @override
  _YoChartScreenState createState() => _YoChartScreenState();
}

class _YoChartScreenState extends State<YoChartScreen> {
  @override
  Widget build(BuildContext context){
    final GliderArguments args =
    ModalRoute.of(context).settings.arguments as GliderArguments;
    ErddapDataList _erddapDataList = ErddapDataList();
    Map<String,Future<List<dynamic>>> dataMap = _erddapDataList.dataMap;
    Future<List<dynamic>> future = dataMap[args.deploymentName];
    return Scaffold(
      appBar: AppBar(
        title: Text('YO Chart'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return new charts.TimeSeriesChart(
                TimeData.buildYODataList(snapshot.data,args.before),
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
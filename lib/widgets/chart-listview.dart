// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/yo-chart-screen.dart';
// import '../charts/yo-chart.dart';
import '../yo-chart-screen.dart';
import '../pressure-chart-screen.dart';

Widget chartList(BuildContext context,String deploymentName,int before){
  final List<dynamic> chartList = ['YO Chart','Pressure vs. Time'];

    return Scaffold(
      body:Container(
        child: ListView.builder(
          padding: EdgeInsets.all(3),
          itemCount: chartList.length,
          itemBuilder: (BuildContext context, int index){
            return
              GestureDetector(
                onTap: (){
                  if(chartList[index]=='YO Chart'){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YoChartScreen(),
                        settings: RouteSettings(
                          arguments: GliderArguments(deploymentName,before),
                        ),
                      ),
                    );
                  }
                  else if(chartList[index]=='Pressure vs. Time'){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PressureChartScreen(),
                        settings: RouteSettings(
                          arguments: GliderArguments(deploymentName,before),
                        ),
                      ),
                    );
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context)=>new YoScatterPlot(SLAPI.getDeploymentName(snapshot.data[index]),12))
                  //    );
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(chartList[index]),
                      )
                    ],
                  ),
                ),
              );
          }
        )
      )
    );
}
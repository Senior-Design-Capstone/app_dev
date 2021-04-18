import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../charts/yo-chart.dart';

class ChartList extends StatelessWidget{
  final List<dynamic> chartList = ['YO Chart','Pressure vs. Time'];
  final String deploymentName;
  final int before;

  ChartList(this.deploymentName,this.before);

  @override
  Widget build(BuildContext context){
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context)=>new YoScatterPlot(this.deploymentName,this.before))
                  //    );
                  }
                  else if(chartList[index]=='Pressure vs. Time'){

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
}
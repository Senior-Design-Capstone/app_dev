import 'package:flutter/cupertino.dart';
import 'package:mobile_app/charts/yo-chart.dart';

class GliderArguments{
  final String deploymentName;
  final int before;
  GliderArguments(this.deploymentName,this.before);
}

class YoChartScreen extends StatelessWidget{
  static const routeName= '/details/yochart';
  @override
  Widget build(BuildContext context){
    final GliderArguments args =
      ModalRoute.of(context)!.settings.arguments as GliderArguments;
    return YoScatterPlot(args.deploymentName,args.before);
  }
}
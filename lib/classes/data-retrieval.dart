import 'package:http/http.dart' as http;
import 'dart:convert';


class Erddap{
  static Uri getRawUrlFromDeploymentName(String deploymentName){
    // return "http://slocum-data.marine.rutgers.edu/erddap/tabledap/"+deploymentName+"-profile-raw-rt.json?time%2Cdepth";
    return Uri.parse("http://slocum-data.marine.rutgers.edu/erddap/tabledap/"+deploymentName+"-profile-raw-rt.json?time%2Clatitude%2Clongitude%2Cdepth%2Csci_water_pressure");
  }
  static Uri getSciUrlFromDeploymentName(String deploymentName){
    return Uri.parse("http://slocum-data.marine.rutgers.edu/erddap/tabledap/"+deploymentName+"-profile-sci-rt.json?time%2Cdepth");
  }
  //create a future list from deploymentname
  static Future<List<dynamic>> fetchData(String deploymentName) async {
    // print(deploymentName);
    // print("Fetching data...");
    var result = await http.get(getRawUrlFromDeploymentName(deploymentName));
    // print("Data fetched!");
    // print(json.decode(result.body)['table']['rows']);
    return json.decode(result.body)['table']['rows'];
  }
}

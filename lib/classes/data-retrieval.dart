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

class SLAPI{
  static final apiUri = Uri.parse("https://marine.rutgers.edu/cool/data/gliders/api/deployments/?active");
  static final testApiUri = Uri.parse("https://marine.rutgers.edu/cool/data/gliders/api/deployments/");
  static Future<List<dynamic>> fetchGliders() async {
    var result = await http.get(apiUri);
    return json.decode(result.body)['data'];
  }
  
  static String getGliderName(dynamic glider) {
    return glider['glider_name'];
  }

  static String getDeploymentName(dynamic glider) {
    return glider['deployment_name'];
  }

  static String getGliderId(dynamic glider) {
    return "Glider ID: " + glider['glider_id'].toString();
  }

  static String getGliderLat(dynamic glider) {
    return glider['last_surfacing']['gps_lat'].toString();
  }

  static String getGliderLon(dynamic glider) {
    return glider['last_surfacing']['gps_lon'].toString();
  }

  static String getGliderGPSTime(dynamic glider) {
    return glider['last_surfacing']['gps_timestamp_epoch'].toString();
  }

  static int getGliderConnectTime(dynamic glider) {
    return glider['last_surfacing']['connect_time_epoch'] * 1000;
  }

  static String getGliderSurfaceReason(dynamic glider) {
    return glider['last_surfacing']['surface_reason'].toString();
  }

  static String getTimeSinceLastCall(dynamic glider) {
    int msecsCall = glider['last_surfacing']['connect_time_epoch'] * 1000;
    // DateTime lastCallTime = DateTime.fromMillisecondsSinceEpoch(msecsCall);
    DateTime current = DateTime.now();
    String sHours, sMinutes, sSeconds;
    int timeSinceLastCallmsecs = current.millisecondsSinceEpoch - msecsCall;
    int timeSinceLastCallsecs = (timeSinceLastCallmsecs / 1000).truncate();
    int hours = (timeSinceLastCallsecs / 3600).truncate();
    int minutes = ((timeSinceLastCallsecs % 3600) / 60).truncate();
    int seconds = (timeSinceLastCallsecs % 3600) % 60;
    if (hours < 10) {
      sHours = "0" + hours.toString();
    } else {
      sHours = hours.toString();
    }
    if (minutes < 10) {
      sMinutes = "0" + minutes.toString();
    } else {
      sMinutes = minutes.toString();
    }
    if (seconds < 10) {
      sSeconds = "0" + seconds.toString();
    } else {
      sSeconds = seconds.toString();
    }
    return sHours + ":" + sMinutes + ":" + sSeconds;
  }
}

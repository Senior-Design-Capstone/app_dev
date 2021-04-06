import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_app/details-screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:intl/intl.dart';

class MainMap extends StatefulWidget {
  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Future<Null> _refresh() {
  //   //ADD REFRESH STUFF
  //   //https://medium.com/codechai/adding-swipe-to-refresh-to-flutter-app-b234534f39a7
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RU COOL'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Stack(
        children: <Widget>[
          // RefreshIndicator(
          //   child: child,
          //   onRefresh: _refresh,
          // ),
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            onMapCreated: _onMapCreated,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    onPressed: () => print('add menu stuff here?'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.menu,
                      size: 36.0,
                      color: Colors.black45,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    onPressed: () => print('add refresh here'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.refresh,
                      size: 36.0,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.10,
            maxChildSize: 0.45,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: CustomScrollViewContent(),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Content of the DraggableBottomSheet's child SingleChildScrollView
class CustomScrollViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 24.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: CustomInnerContent(),
      ),
    );
  }
}

class CustomInnerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        DraggingHandle(),
        SizedBox(height: 16),
        ActiveDeploymentsTitle(),
        SizedBox(height: 16),
        ActiveDeploymentsListView(),
        Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}

class DraggingHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
    );
  }
}

class ActiveDeploymentsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Active Deployments",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black45,
          ),
        ),
      ],
    );
  }
}

class ActiveDeploymentsListView extends StatefulWidget {
  @override
  _ActiveDeploymentsListViewState createState() =>
      _ActiveDeploymentsListViewState();
}

class _ActiveDeploymentsListViewState extends State<ActiveDeploymentsListView> {
  final apiUri = Uri.parse(
      "https://marine.rutgers.edu/cool/data/gliders/api/deployments/?active");

  Future<List<dynamic>> fetchGliders() async {
    var result = await http.get(apiUri);
    return json.decode(result.body)['data'];
  }

  String getGliderName(dynamic glider) {
    return glider['glider_name'];
  }

  String getDeploymentName(dynamic glider) {
    return glider['deployment_name'];
  }

  String getGliderId(dynamic glider) {
    return "Glider ID: " + glider['glider_id'].toString();
  }

  String getGliderLat(dynamic glider) {
    return glider['gps_lat'].toString();
  }

  String getGliderLon(dynamic glider) {
    return glider['gps_lon'].toString();
  }

  String getGliderGPSTime(dynamic glider) {
    return glider['gps_timestamp_epoch'].toString();
  }

  int getGliderConnectTime(dynamic glider) {
    return glider['last_surfacing']['connect_time_epoch'] * 1000;
  }

  String getGliderSurfaceReason(dynamic glider) {
    return glider['last_surfacing']['surface_reason'].toString();
  }

  String getTimeSinceLastCall(dynamic glider) {
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

  @override
  Widget build(BuildContext context) {
    // final activeDeploymentsList = ['test1', 'test2', 'test3', 'test4'];

    // Widget nameAndStatus = Expanded(
    //   child: Row(
    //     children: <Widget>[
    //       Icon(
    //         Icons.directions_boat_outlined,
    //         color: Colors.yellow,
    //       ),
    //       Padding(padding: EdgeInsets.all(8)),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Text(
    //             'glider name',
    //             style: TextStyle(
    //               fontSize: 16,
    //             ),
    //           ),
    //           Text(
    //             'glider status',
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );

    // Widget lastCallTime = Expanded(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.end,
    //     children: <Widget>[
    //       Text(
    //         'hours:mins:secs',
    //         style: TextStyle(
    //           fontSize: 16,
    //         ),
    //       ),
    //       Text(
    //         'Since last call',
    //       ),
    //     ],
    //   ),
    // );

    return FutureBuilder<List<dynamic>>(
      future: fetchGliders(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Details()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          //this is the nameandstatus widget
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.directions_boat_outlined,
                                  color: Colors.yellow,
                                ),
                                Padding(padding: EdgeInsets.all(8)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      getGliderName(snapshot.data[index]),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      getGliderSurfaceReason(
                                          snapshot.data[index]),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //this is the lastcall time widget
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  getTimeSinceLastCall(snapshot.data[index]),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Since last call',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

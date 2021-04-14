import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/classes/glider-list-single.dart';
import 'package:mobile_app/details-screen.dart';
import 'widgets/glider-status-info-widgets.dart';
import 'classes/data-retrieval.dart';
import 'classes/glider-list-single.dart';
import 'dart:async';

// import 'package:intl/intl.dart';

class MainMap extends StatefulWidget {
  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  GliderList _gliderList = GliderList();

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //Add the timer that will automatically update time since last call
  @override
  void initState() {
    super.initState();
    setState(() {
      const oneSecond = const Duration(seconds: 1);
      new Timer.periodic(
          oneSecond,
          (Timer t) => setState(() {
                _gliderList.updateTime();
              }));
    });
  }

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
                    //On press, refreshes the glider list and rebuilds widget
                    onPressed: () {
                      setState(() {
                        _gliderList.updateList();
                      });
                    },
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
            initialChildSize: .1,
            minChildSize: .1,
            maxChildSize: .45,
            builder: (BuildContext context, ScrollController scrollController) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: CustomScrollViewContent(),
                    ),
                  ),
                ],
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
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(24),
        // ),
        child: CustomInnerContent(),
      ),
    );
  }
}

class CustomInnerContent extends StatelessWidget {
  GliderList _gliderList = GliderList();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        DraggingHandle(),
        SizedBox(height: 16),
        ActiveDeploymentsTitle(),
        Row(
          children: <Widget>[
            Text(
              'Last Refresh: ',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(
              DateFormat('MM-dd HH:mm').format(_gliderList.timeOfLastRefresh),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
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
            color: Colors.black,
            fontWeight: FontWeight.bold,
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

//https://medium.com/codechai/switching-widgets-885d9b5b5c6f For switching widgets
class _ActiveDeploymentsListViewState extends State<ActiveDeploymentsListView> {
  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  // late Future<List<dynamic>> gliderList;

  // @override
  // void initState() {
  //   super.initState();
  //   gliderList=SLAPI.fetchGliders();
  // }
  GliderList _gliderList = GliderList();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _gliderList.list,
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
                          NameAndStatus(
                              SLAPI.getGliderName(snapshot.data[index]),
                              SLAPI.getGliderSurfaceReason(
                                  snapshot.data[index])),
                          //this is the lastcall time widget
                          LastCallTime(
                              SLAPI.getTimeSinceLastCall(snapshot.data[index])),
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

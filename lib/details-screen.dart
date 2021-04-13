import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'classes/glider-list-single.dart';
import 'classes/data-retrieval.dart';
import 'classes/erddap-data-singleton.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.15,
            maxChildSize: 1,
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
        SizedBox(height: 30),
        DetailsSheet(),
        SizedBox(height: 30),
      ],
    );
  }
}

class DetailsSheet extends StatefulWidget {
  @override
  _DetailsSheetState createState() => _DetailsSheetState();
}

class _DetailsSheetState extends State<DetailsSheet> {
  GliderList _gliderList = GliderList();
  ErddapDataList _erddapDataList = ErddapDataList();
  List<String> productData = ['test1', 'test2', 'test3', 'test4', 'test5'];
  @override
  void initState(){
    super.initState();
    _erddapDataList.updateMap();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 5,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
        ),
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //This is the horizontal listview that has the individual glider data
            child: FutureBuilder<List<dynamic>>(
              future: _gliderList.list,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData){
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(SLAPI.getGliderName(snapshot.data[index])),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('battery %'),
                                  Text('time left on battery'),
                                ],
                              ),
                            ),
                            DataTable(),
                            Expanded(
                              child: CallTabs(),
                            ),
                            //DataTable(),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                else{
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ),
      ],
    );
  }
}

class DataTable extends StatefulWidget {
  @override
  _DataTableState createState() => _DataTableState();
}

//I think this is the battery % data table
class _DataTableState extends State<DataTable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: MediaQuery.of(context).size.width * .4,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class LastCallPlots extends StatefulWidget {
  @override
  _LastCallPlotsState createState() => _LastCallPlotsState();
}

class _LastCallPlotsState extends State<LastCallPlots> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('(Last Call) YO Diag Plot'),
            Text('# yos'),
            Text('%'),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.width * .4,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Padding(padding: EdgeInsets.all(8)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('(Last Call) Pressure vs. Time'),
            Text('%'),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.width * .4,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}

class SecondPrevPlots extends StatefulWidget {
  @override
  _SecondPrevPlotsState createState() => _SecondPrevPlotsState();
}

class _SecondPrevPlotsState extends State<SecondPrevPlots> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('(2nd Previous) YO Diag Plot'),
            Text('# yos'),
            Text('%'),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.width * .4,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Padding(padding: EdgeInsets.all(8)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('(2nd Previous) Pressure vs. Time'),
            Text('%'),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.width * .4,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}

class ThirdPrevPlots extends StatefulWidget {
  @override
  _ThirdPrevPlotsState createState() => _ThirdPrevPlotsState();
}

class _ThirdPrevPlotsState extends State<ThirdPrevPlots> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('(3rd Previous) YO Diag Plot'),
            Text('# yos'),
            Text('%'),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.width * .4,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Padding(padding: EdgeInsets.all(8)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('(3rd Previous) Pressure vs. Time'),
            Text('%'),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.width * .4,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}

class CallTabs extends StatefulWidget {
  @override
  _CallTabsState createState() => _CallTabsState();
}

class _CallTabsState extends State<CallTabs> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    TabBar(
                      tabs: [
                        Tab(text: 'Last Call'),
                        Tab(text: '2nd Previous'),
                        Tab(text: '3rd Previous'),
                      ],
                      labelColor: Colors.black12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              LastCallPlots(),
              SecondPrevPlots(),
              ThirdPrevPlots(),
            ],
          ),
        ),
      ),
    );
  }
}

// class _CallTabsState extends State<CallTabs> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: TabBar(
//               tabs: [
//                 Tab(
//                   text: 'Last Call',
//                 ),
//                 Tab(
//                   text: '2nd Previous',
//                 ),
//                 Tab(
//                   text: '3rd Previous',
//                 ),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               Icon(Icons.directions_car),
//               Icon(Icons.directions_transit),
//               Icon(Icons.directions_bike),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

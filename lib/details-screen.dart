import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  List<String> productData = ['test1', 'test2', 'test3', 'test4', 'test5'];
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productData.length,
              itemBuilder: (BuildContext context, int i) => Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('glider name, swipey swipe'),
                      DataTable(),
                      Text('https://sgdfgdgd/jdkjdhj.png/jashdghd'),
                      Text('20'),
                      Text('akhsgdahghsgdh')
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

class DataTable extends StatefulWidget {
  @override
  _DataTableState createState() => _DataTableState();
}

class _DataTableState extends State<DataTable> {
  List<String> missions = ['test1', 'test2', 'test3', 'test4', 'test5'];
  List<String> vmgWptEta = ['test1', 'test2', 'test3', 'test4', 'test5'];
  List<String> callTimes = ['test1', 'test2', 'test3', 'test4', 'test5'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
// class CustomHorizontallyScrollingRestaurants extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 16,
//         top: 50,
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             CustomRestaurantCategory(),
//             SizedBox(width: 12),
//             CustomRestaurantCategory(),
//             SizedBox(width: 12),
//             CustomRestaurantCategory(),
//             SizedBox(width: 12),
//             CustomRestaurantCategory(),
//             SizedBox(width: 12),
//           ],
//         ),
//       ),
//     );
//   }
// }

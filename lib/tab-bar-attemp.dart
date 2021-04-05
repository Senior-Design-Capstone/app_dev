// import 'package:flutter/material.dart';

// class CallTabs extends StatefulWidget {
//   @override
//   _CallTabsState createState() => _CallTabsState();
// }

// class _CallTabsState extends State<CallTabs>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = new TabController(length: 3, vsync: this);
//     _tabController.addListener(() => setState(() {}));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(color: Colors.red,
//             child: TabBar(
//               controller: _tabController,
//               tabs: [
//                 Tab(
//                   text: 'session',
//                 ),
//                 Tab(
//                   text: '2 hrs',
//                 ),
//                 Tab(
//                   text: '8hrs',
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: <Widget>[
//                 Card(
//                   child: Text('session text'),
//                 ),
//                 Card(
//                   child: Text('2 hrs text'),
//                 ),
//                 Card(
//                   child: Text('8 hrs text'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

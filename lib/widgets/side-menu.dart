import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(50),
        children: <Widget>[
          // DrawerHeader(
          //   child: Text(
          //     'Menu',
          //     style: TextStyle(color: Colors.white, fontSize: 25),
          //   ),
          //   decoration: BoxDecoration(
          //     color: Colors.green,
          //     image: DecorationImage(
          //       fit: BoxFit.fill,
          //       image: AssetImage('assets/cover.jpg'),
          //     ),
          //   ),
          // ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Map Center'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../classes/glider-list-single.dart';

class NameAndStatus extends StatelessWidget {
  final String gliderName, gliderStatus;
  final int i;
  NameAndStatus(this.gliderName, this.gliderStatus,this.i);

  @override
  Widget build(BuildContext context) {
    GliderList _gliderList = GliderList();
    return Expanded(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.directions_boat_outlined,
            color: _gliderList.colors[i],
          ),
          Padding(padding: EdgeInsets.all(8)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.gliderName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                this.gliderStatus,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LastCallTime extends StatelessWidget {
  final String time;
  LastCallTime(this.time);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            this.time,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Since last call',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

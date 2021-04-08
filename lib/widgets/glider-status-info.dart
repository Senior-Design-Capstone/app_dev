import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameAndStatus extends StatelessWidget{
  final String gliderName,gliderStatus;
  NameAndStatus(this.gliderName,this.gliderStatus);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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

class LastCallTime extends StatelessWidget{
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
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aravindputhoor',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 19.0)),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.menu, color: Colors.black, size: 30.0),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}

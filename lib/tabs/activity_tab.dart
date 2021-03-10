import 'package:flutter/material.dart';
import 'package:instagram_ui_flutter/widgets/activity_tile.dart';
import 'package:instagram_ui_flutter/widgets/activity_tile_alt.dart';
import 'package:instagram_ui_flutter/widgets/suggestions_tile.dart';

class ActivityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks', style: TextStyle(color: Colors.black)),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 5.0),
            child: Text('Bookmarked posts',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
          ),
          ActivityTileAlt(
              username: 'samwilson:  ',
              mention: true,
              image: 'assets/story12.jpg'),
        ],
      ),
    );
  }
}

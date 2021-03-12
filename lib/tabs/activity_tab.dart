import 'package:flutter/material.dart';
import 'package:instagram_ui_flutter/models/news_feed.dart';
import 'package:instagram_ui_flutter/widgets/activity_tile.dart';
// import 'package:instagram_ui_flutter/widgets/activity_tile_alt.dart';
// import 'package:instagram_ui_flutter/widgets/suggestions_tile.dart';
import 'package:instagram_ui_flutter/dbmanager.dart';
import 'package:instagram_ui_flutter/widgets/bookmarks.dart';

class ActivityTab extends StatefulWidget {
  @override
  _ActivityTabState createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  final DbStudentManager dbmanager = new DbStudentManager();
  List<Newsfeed> newsFeed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks', style: TextStyle(color: Colors.black)),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: dbmanager.getNewsfeedList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            newsFeed = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: newsFeed == null ? 0 : newsFeed.length,
              itemBuilder: (BuildContext context, int index) {
                Newsfeed nf = newsFeed[index];
                return Bookmark(
                  id: nf.id,
                  image: nf.thumbnail,
                  name: nf.channelname,
                  title: nf.title,
                );
                // return Card(
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         width: 300,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Text(
                //               'Name: ${nf.channelname}',
                //               style: TextStyle(fontSize: 15),
                //             ),
                //             Text(
                //               'Course: ${nf.title}',
                //               style: TextStyle(
                //                   fontSize: 15, color: Colors.black54),
                //             ),
                //           ],
                //         ),
                //       ),
                //       IconButton(
                //         onPressed: () {},
                //         icon: Icon(
                //           Icons.edit,
                //           color: Colors.blueAccent,
                //         ),
                //       ),
                //       IconButton(
                //         onPressed: () {
                //           dbmanager.deleteNewsfeed(nf.id);
                //           setState(() {
                //             newsFeed.removeAt(index);
                //           });
                //         },
                //         icon: Icon(
                //           Icons.delete,
                //           color: Colors.red,
                //         ),
                //       )
                //     ],
                //   ),
                // );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.grey, strokeWidth: 1.0),
            );
          }
        },
      ),
    );
  }
}

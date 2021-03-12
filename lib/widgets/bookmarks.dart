import 'package:flutter/material.dart';
import 'package:instagram_ui_flutter/dbmanager.dart';
import 'package:instagram_ui_flutter/models/news_feed.dart';

class Bookmark extends StatefulWidget {
  final String id;
  final String name;
  final String title;
  final String image;

  Bookmark({this.id, this.name, this.title, this.image});

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  final DbManager dbmanager = new DbManager();

  @override
  Widget build(BuildContext context) {
    Newsfeed nf = Newsfeed(
        id: widget.id,
        channelname: widget.name,
        thumbnail: widget.image,
        title: widget.title);

    return GestureDetector(
      onTap: () {
        print('object');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              child: Image.network(widget.image, fit: BoxFit.cover),
            ),
            SizedBox(width: 10.0),
            Container(
              width: MediaQuery.of(context).size.width / 1.8,
              child: Text.rich(
                TextSpan(
                  text: widget.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: '  ${widget.title}',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  dbmanager.deleteNewsfeed(widget.id).then((id) {
                    final snackBar = SnackBar(
                      content: Text('Bookmark Removed'),
                      duration: Duration(seconds: 1),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                }),
          ],
        ),
      ),
    );
  }
}

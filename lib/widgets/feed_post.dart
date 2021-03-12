import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_ui_flutter/pages/comments_page.dart';
import 'package:instagram_ui_flutter/read_more_text.dart';
import 'package:instagram_ui_flutter/dbmanager.dart';
import 'package:instagram_ui_flutter/models/news_feed.dart';

class FeedPost extends StatefulWidget {
  final String id;
  final String username;
  final int likes;
  final String time;
  final String profilePicture;
  final String image;
  final String title;

  FeedPost(
      {this.id,
      this.username,
      this.likes,
      this.time,
      this.profilePicture,
      this.image,
      this.title});

  @override
  _FeedPostState createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  bool isLiked = false;
  bool displayHeart = false;
  bool bookMark = false;
  final DbStudentManager dbmanager = new DbStudentManager();

  @override
  Widget build(BuildContext context) {
    Newsfeed nf = Newsfeed(
      id: widget.id,
      channelname: widget.username,
      thumbnail: widget.image,
      title: widget.title,
    );

    // dbmanager.updateNewsfeed(nf).then((value) {
    //   setState(() {
    //     bookMark = true;
    //   });
    // });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage(widget.profilePicture),
                  ),
                  SizedBox(width: 10.0),
                  Text(widget.username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0)),
                ],
              ),
              Icon(Icons.more_vert)
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              isLiked = !isLiked;
              displayHeart = true;
            });
            Future.delayed(const Duration(milliseconds: 750), () {
              setState(() {
                displayHeart = false;
              });
            });
          },
          child: displayHeart == true
              ? Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: Image.network(widget.image, fit: BoxFit.cover),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Icon(FontAwesomeIcons.solidHeart,
                                color: Colors.white, size: 80.0))),
                  ],
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Image.network(widget.image, fit: BoxFit.cover),
                ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLiked == true
                      ? Icon(FontAwesomeIcons.solidHeart,
                          color: Colors.red, size: 25.0)
                      : Icon(FontAwesomeIcons.heart, size: 25.0),
                  SizedBox(width: 15.0),
                  Icon(FontAwesomeIcons.comment, size: 25.0),
                  SizedBox(width: 15.0),
                  Icon(FontAwesomeIcons.paperPlane, size: 25.0),
                ],
              ),
              bookMark == false
                  ? IconButton(
                      icon: Icon(FontAwesomeIcons.bookmark, size: 25.0),
                      onPressed: () {
                        dbmanager.insertNewsfeed(nf).then((id) {
                          final snackBar = SnackBar(
                            content: Text('Post Bookmarked'),
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          print('NewsFeed Added to Db $id');
                          setState(() {
                            bookMark = true;
                          });
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(FontAwesomeIcons.solidBookmark),
                      onPressed: () {
                        dbmanager.deleteNewsfeed(widget.id).then((id) {
                          final snackBar = SnackBar(
                            content: Text('Bookmark Removed'),
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          setState(() {
                            bookMark = false;
                          });
                        });
                      },
                    ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('${widget.likes} likes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: ReadMoreText(
            widget.title,
            trimLines: 1,
            colorClickableText: Colors.blueGrey[300],
            trimMode: TrimMode.Line,
            trimCollapsedText: '...Read more',
            trimExpandedText: ' Less',
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentsPage(),
                  ),
                );
              },
              child: Text('View Comments',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ))),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Text('${widget.time} ago',
              style: TextStyle(fontSize: 12.0, color: Colors.grey)),
        )
      ],
    );
  }
}

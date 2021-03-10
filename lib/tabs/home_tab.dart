import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:instagram_ui_flutter/pages/messages_page.dart';
import 'package:instagram_ui_flutter/providers/news_feed.dart';
import 'package:instagram_ui_flutter/widgets/feed_post.dart';
import 'package:instagram_ui_flutter/widgets/stories_widget.dart';

import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future _launchCamera() async {
    // final _image = await ImagePicker().getImage(source: ImageSource.camera);
  }

  var _isInIt = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInIt) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<NewsFeed>(context).fetchAndSetFeeds().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInIt = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final feedProvider = Provider.of<NewsFeed>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        title: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                  onTap: _launchCamera,
                  child: Icon(FontAwesomeIcons.camera,
                      color: Colors.black, size: 30.0)),
              SizedBox(width: 30.0),
              Text('Instagram',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Billabong',
                      fontSize: 30.0))
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MessagesPage()));
                },
                child: Icon(FontAwesomeIcons.paperPlane, color: Colors.black)),
          )
        ],
      ),
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.grey, strokeWidth: 1.0))
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  StoriesWidget(),
                  Column(
                    children: List.generate(
                      feedProvider.feeds.length,
                      (index) => FeedPost(
                        username: feedProvider.feeds[index].channelname,
                        likes: 102,
                        time: '2 hours',
                        profilePicture: 'assets/user.jpg',
                        image: feedProvider.feeds[index].thumbnail,
                        title: feedProvider.feeds[index].title,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

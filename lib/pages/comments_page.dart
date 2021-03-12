import 'package:flutter/material.dart';
import 'package:instagram_ui_flutter/providers/news_feed.dart';
import 'package:instagram_ui_flutter/widgets/activity_tile.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatefulWidget {
  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  var _isInIt = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInIt) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<NewsFeed>(context).fetchAndSetComments().then((_) {
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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text('Comments', style: TextStyle(color: Colors.black)),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.grey, strokeWidth: 1.0))
          : ListView(
              children: List.generate(
                feedProvider.comments.length,
                (index) => ActivityTile(
                  username: feedProvider.comments[index].username,
                  profilePicture: 'assets/user.jpg',
                  comment: feedProvider.comments[index].comments,
                ),
              ),
            ),
    );
  }
}

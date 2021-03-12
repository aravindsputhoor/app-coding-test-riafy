import 'package:flutter/material.dart';
import 'package:instagram_ui_flutter/models/news_feed.dart';
// import 'package:instagram_ui_flutter/widgets/activity_tile.dart';
// import 'package:instagram_ui_flutter/widgets/activity_tile_alt.dart';
// import 'package:instagram_ui_flutter/widgets/suggestions_tile.dart';
import 'package:instagram_ui_flutter/dbmanager.dart';
import 'package:instagram_ui_flutter/widgets/bookmarks.dart';
import 'package:provider/provider.dart';

class ActivityTab extends StatefulWidget {
  @override
  _ActivityTabState createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  List<Newsfeed> newsFeed;

  var _isInIt = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInIt) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<DbManager>(context).getNewsfeedList().then((_) {
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
    final dbProvider = Provider.of<DbManager>(context);
    newsFeed = dbProvider.postItems;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks', style: TextStyle(color: Colors.black)),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
      body: newsFeed == null
          ? Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.grey, strokeWidth: 1.0),
            )
          : ListView.builder(
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
              },
            ),
    );
  }
}

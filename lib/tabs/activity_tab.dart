import 'package:flutter/material.dart';
import 'package:instagram_ui_flutter/models/news_feed.dart';
// import 'package:instagram_ui_flutter/widgets/activity_tile.dart';
// import 'package:instagram_ui_flutter/widgets/activity_tile_alt.dart';
// import 'package:instagram_ui_flutter/widgets/suggestions_tile.dart';
import 'package:instagram_ui_flutter/dbmanager.dart';
// import 'package:instagram_ui_flutter/widgets/bookmarks.dart';
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
              child: Text('No Bookmarks'),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: newsFeed == null ? 0 : newsFeed.length,
              itemBuilder: (BuildContext context, int index) {
                Newsfeed nf = newsFeed[index];
                return GestureDetector(
                  onTap: () {
                    print('object');
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          height: 50.0,
                          child: Image.network(nf.thumbnail, fit: BoxFit.cover),
                        ),
                        SizedBox(width: 10.0),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text.rich(
                            TextSpan(
                              text: nf.channelname,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '  ${nf.title}',
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
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Alert'),
                                  content: Text(
                                      'Do you want to remove this bookmark ?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        dbProvider
                                            .deleteNewsfeed(nf.id)
                                            .then((id) {
                                          Navigator.pop(context, 'Yes');
                                          final snackBar = SnackBar(
                                            content: Text('Bookmark Removed'),
                                            duration: Duration(seconds: 1),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          setState(() {
                                            newsFeed = dbProvider.postItems;
                                          });
                                        });
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

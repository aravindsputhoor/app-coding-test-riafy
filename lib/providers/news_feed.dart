import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:instagram_ui_flutter/models/comments.dart';
import 'package:instagram_ui_flutter/models/feed.dart';

class NewsFeed with ChangeNotifier {
  List<Feed> _feeds = [];
  List<Comment> _comments = [];
  List<Feed> get feeds {
    return [..._feeds];
  }

  List<Comment> get comments {
    return [..._comments];
  }

  Future<void> fetchAndSetFeeds() async {
    const url =
        'https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas';
    final response = await http.get(url);

    final extractedData = json.decode(response.body) as dynamic;
    if (extractedData == null) {
      return;
    }

    final List<Feed> loadedFeeds = [];
    var n = extractedData.length;

    for (var i = 0; i < n; i++) {
      loadedFeeds.add(
        Feed(
          id: extractedData[i]['id'],
          channelname: extractedData[i]['channelname'],
          thumbnail: extractedData[i]['medium thumbnail'],
          title: extractedData[i]['title'],
        ),
      );
    }
    _feeds = loadedFeeds;
    // print(json.decode(response.body));
  }

  Future<void> fetchAndSetComments() async {
    const url1 = 'https://cookbookrecipes.in/test.php';
    final response1 = await http.get(url1);
    final extractedData1 = json.decode(response1.body) as dynamic;

    // print(json.decode(response1.body));

    if (extractedData1 == null) {
      return;
    }
    final List<Comment> loadedComments = [];
    var n = extractedData1.length;

    for (var i = 0; i < n; i++) {
      loadedComments.add(
        Comment(
            username: extractedData1[i]['username'],
            comments: extractedData1[i]['comments']),
      );
    }
    _comments = loadedComments;
  }
}

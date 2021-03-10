import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:instagram_ui_flutter/models/feed.dart';

class NewsFeed with ChangeNotifier {
  List<Feed> _feeds = [];
  List<Feed> get feeds {
    return [..._feeds];
  }

  Future<void> fetchAndSetFeeds() async {
    const url =
        'https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas';
    final response = await http.get(url);

    final extractedData = json.decode(response.body) as dynamic;
    if (extractedData == null) {
      return;
    }
    print(extractedData[1]['id']);
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
}

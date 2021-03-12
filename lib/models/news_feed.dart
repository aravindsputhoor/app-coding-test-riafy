import 'package:flutter/material.dart';

class Newsfeed {
  final String id;
  final String channelname;
  final String title;
  final String thumbnail;
  Newsfeed({
    @required this.id,
    @required this.channelname,
    @required this.thumbnail,
    @required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'channelname': channelname,
      'thumbnail': thumbnail,
      'title': title
    };
  }
}

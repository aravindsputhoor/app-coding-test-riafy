import 'package:flutter/material.dart';
import 'package:instagram_ui_flutter/dbmanager.dart';
import 'package:instagram_ui_flutter/pages/home_page.dart';
import 'package:instagram_ui_flutter/providers/news_feed.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => NewsFeed(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DbManager(),
        ),
      ],
      child: MaterialApp(
        title: 'Instagram App',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:github_finder/features/github_finder/presentation/pages/search_users_page.dart';

class GithubFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Github Finder',
      home: SearchUsersPage(),
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.grey.shade800,
        accentColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
    );
  }
}

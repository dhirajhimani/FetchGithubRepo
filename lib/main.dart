import 'package:flutter/material.dart';
import 'package:githubrepos/widgets/github_repos_widget.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

// Test comment 8
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GithubReposWidget(
        client: http.Client(),
        title: 'Github Repos',
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:githubrepos/model/model.dart';
import 'package:githubrepos/services/ApiService.dart';
import 'package:http/http.dart' as http;

class GithubReposWidget extends StatefulWidget {
  GithubReposWidget({Key? key, required this.client, required this.title}) : super(key: key);
  final http.Client client;
  final String title;

  @override
  _GithubReposWidgetState createState() => _GithubReposWidgetState();
}

class _GithubReposWidgetState extends State<GithubReposWidget> {
  late final Future<GithubRepos> githubRepos;

  @override
  void initState() {
    super.initState();
    githubRepos = fetchRepos(widget.client);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<GithubRepos>(
          future: githubRepos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: Icon(Icons.list_rounded),
                        title: Text("${snapshot.data!.items[index].name}"));
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

import 'package:githubrepos/model/model.dart';
import 'package:http/http.dart' as http;

Future<GithubRepos> fetchRepos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://api.github.com/search/repositories?q=flutter'));

  if (response.statusCode == 200) {
    return githubReposFromJson(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}

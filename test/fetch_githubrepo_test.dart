import 'package:flutter_test/flutter_test.dart';
import 'package:githubrepos/model/model.dart';
import 'package:githubrepos/services/ApiService.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_githubrepo_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchGithubRepos', () {
    test('returns an GithubRepos if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(
              'https://api.github.com/search/repositories?q=flutter')))
          .thenAnswer((_) async => http.Response(
              '{"items":[{"name": "flutter_1"},{"name":  "flutter_2"}]}',
              200));

      expect(await fetchRepos(client), isA<GithubRepos>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(
              'https://api.github.com/search/repositories?q=flutter')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchRepos(client), throwsException);
    });
  });
}

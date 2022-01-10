import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:githubrepos/main.dart';
import 'package:githubrepos/widgets/github_repos_widget.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_githubrepo_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  testWidgets('Github Repos Fetch smoke test', (WidgetTester tester) async {
    final client = MockClient();

    // Use Mockito to return a successful response when it calls the
    // provided http.Client.
    when(client.get(
            Uri.parse('https://api.github.com/search/repositories?q=flutter')))
        .thenAnswer((_) async => http.Response(
            '{"items":[{"name": "flutter_1"},{"name":  "flutter_2"}]}', 200));

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: GithubReposWidget(title: 'GithubRepos', client: client)));

    await tester.pumpWidget(testWidget);

    await tester.pumpAndSettle();

    expect(find.text('GithubRepos'), findsOneWidget);
    expect(find.text('flutter_1'), findsOneWidget);
    expect(find.text('flutter_3'), findsNothing);
  });
}

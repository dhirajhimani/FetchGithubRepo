import 'dart:convert';

GithubRepos githubReposFromJson(String str) =>
    GithubRepos.fromJson(json.decode(str));

String githubReposToJson(GithubRepos data) => json.encode(data.toJson());

class GithubRepos {
  GithubRepos({
    required this.items,
  });

  List<Item> items;

  factory GithubRepos.fromJson(Map<String, dynamic> json) => GithubRepos(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    required this.name,
  });

  String name;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

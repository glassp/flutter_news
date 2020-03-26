import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:flutter_news/models/Article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ArticleState.g.dart';

@JsonSerializable(nullable: false)

///The state that holds the news Articles
class ArticleState {
  final List<Article> articles;

  ArticleState({this.articles});
  factory ArticleState.fromJson(Map<String, dynamic> json) =>
      _$ArticleStateFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleStateToJson(this);

  ArticleState copy({List<Article> articles}) =>
      ArticleState(articles: articles ?? this.articles);

  static ArticleState initialState() => ArticleState(articles: []);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ArticleState &&
            runtimeType == other.runtimeType &&
            listEquals(articles, other.articles);
  }

  @override
  int get hashCode => const ListEquality().hash(articles);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArticleState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleState _$ArticleStateFromJson(Map<String, dynamic> json) {
  return ArticleState(
    articles: (json['articles'] as List)
        .map((e) => Article.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ArticleStateToJson(ArticleState instance) =>
    <String, dynamic>{
      'articles': instance.articles,
    };

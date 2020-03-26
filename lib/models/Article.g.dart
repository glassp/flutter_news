// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['url'] as String,
    json['title'] as String,
    author: json['author'] as String,
    description: json['description'] as String,
    publishedAt: json['publishedAt'] as String,
    content: json['content'] as String,
    urlToImage: json['urlToImage'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'author': instance.author,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
    };

NewsFeed _$NewsFeedFromJson(Map<String, dynamic> json) {
  return NewsFeed(
    (json['articles'] as List)
        .map((e) => Article.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NewsFeedToJson(NewsFeed instance) => <String, dynamic>{
      'articles': instance.articles,
    };

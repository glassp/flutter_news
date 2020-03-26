import 'package:flutter_news/routes/NewsArticleRoute.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'Article.g.dart';

@JsonSerializable(nullable: false)

///the representation of a immutable news article
class Article extends StatelessWidget {
  final String title, description;
  final String author;
  final String publishedAt;
  final String content;
  final String url, urlToImage;

  ///checks if the api truncates the article
  bool get isTruncated =>
      content?.contains(RegExp(r"\[\+[0-9]* chars\]")) ?? true;

  ///The content cleaned of the [+xyz chars]
  ///The getter also checks for null values for when newsapi.org has the audacity to provide a null content
  String get cleanContent => isTruncated
      ? content?.replaceAll(RegExp(r"\[\+[0-9]* chars\]"), "") ??
          "Lese den ganzen Artikel auf der Website"
      : content;

  ///gets the domain name of the website by subsplitting between "//" and the first following "/"
  ///example: domain of https://github.com/flutter/flutter would be github.com
  String get domain => url.substring(
      url.indexOf("//") + 2, url.indexOf("/", url.indexOf("//") + 2));

  ///utility getter to provide a quick access to the DateTime object which corresponds to the publishedAt DateTime String
  DateTime get _time => DateTime.parse(publishedAt);

  ///the human readable DateTime String
  String get time =>
      "${_time.day.toString().padLeft(2, '0')}.${_time.month.toString().padLeft(2, '0')}.${_time.year} ${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}";

  Article(this.url, String title,
      {this.author = "",
      this.description = "",
      String publishedAt,
      this.content = "",
      this.urlToImage = ""})
      : this.title = title.substring(
            0,
            title.lastIndexOf(" - ") > 0 &&
                    title.lastIndexOf(" - ") < title.length
                ? title.lastIndexOf(" - ")
                : title.length),
        this.publishedAt = publishedAt??DateTime.now().toUtc().toString();

  factory Article.fromJson(Map<String, dynamic> json) {
    return _$ArticleFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  ///gets the thumbnail widget even if newsapi.org has the audacity to provide explicit null values in the json
  Widget get thumbnail => urlToImage == null
      ? Image.asset("assets/image-not-found.png")
      : FadeInImage(
          placeholder: AssetImage("assets/image-not-found.png"),
          image: NetworkImage(urlToImage),
        );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => NewsArticleRoute(this))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: thumbnail,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '$title',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 5.0)),
                          Text(
                            '$description',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 2.0)),
                          Text(
                            '$domain   $time',
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

@JsonSerializable(nullable: false)

///utility class used only to deserialize the articles from json
class NewsFeed {
  List<Article> articles;
  NewsFeed([this.articles = const []]);

  factory NewsFeed.fromJson(Map<String, dynamic> json) =>
      _$NewsFeedFromJson(json);

  Map<String, dynamic> toJson() => _$NewsFeedToJson(this);
}

import 'package:flutter/material.dart';
import 'package:flutter_news/models/Article.dart';
import 'package:flutter_news/routes/NewsArticleWebViewRoute.dart';

///The Route that displays a single news article
class NewsArticleRoute extends StatelessWidget {
  final Article article;

  NewsArticleRoute(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsApp"),
      ),
      body: Column(
        children: <Widget>[
          article.thumbnail,
          Text(
            '${article.title}',
            style: Theme.of(context).textTheme.headline4,
          ),
          Padding(
            child: Text('${article.time}   ${article.author??article.domain}'),
            padding: EdgeInsets.symmetric(vertical: 10.0),
          ),
          Text(
            '${article.cleanContent}',
            style: Theme.of(context).textTheme.caption,
          ),
          if (article.isTruncated)
            RaisedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsArticleWebViewRoute(article))),
              child: Text(
                "Zum weiterlesen hier klicken",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
        ],
      ),
    );
  }
}

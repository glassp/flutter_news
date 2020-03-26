import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/models/Article.dart';
import 'package:webview_flutter/webview_flutter.dart';

///The route that can display the full article on the website of the news provider
class NewsArticleWebViewRoute extends StatelessWidget {
  final Article article;

  NewsArticleWebViewRoute(this.article);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(article.url),
        ),
        body: WebView(
          initialUrl: article.url,
          javascriptMode: JavascriptMode.unrestricted,
          userAgent: "Flutter News App",
          //disallow all navigation in the webview
          navigationDelegate: (NavigationRequest request) {
            debugPrint(request.url);
            //if requested page is on the same site or from a CDN allow
            if (request.url.startsWith("https://" + article.domain) ||
                request.url.startsWith(
                    "https://" + article.domain.replaceFirst("www", "m")) ||
                request.url.contains(RegExp('cdn', caseSensitive: false)))
              return NavigationDecision.navigate;
            Flushbar(
              message:
                  'Aus Sicherheitsgründen wurde eine Weiterleitung verhindert.',
              duration: Duration(seconds: 2),
              flushbarStyle: FlushbarStyle.FLOATING,
              flushbarPosition: FlushbarPosition.BOTTOM,
              icon: Icon(Icons.info),
              margin: EdgeInsets.all(8.0),
              borderRadius: 8.0,
              leftBarIndicatorColor: Colors.redAccent,
            )..show(context);
            return NavigationDecision.prevent;
          },
        ));
  }
}

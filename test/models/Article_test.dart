import 'package:flutter_news/models/Article.dart';
import 'package:test/test.dart';

//We need to check if each getter works
//we can make a exception for the thumbnail getter as it is sure to display the placeholder image
// and only if the real image was found it will rebuild the widget with the right image
void main() {
  group("Check if Article was truncated", () {
    //article is truncated if the content contains "[+%d chars]" or is null
    test("Article with content null", () {
      Article article = Article(
        "https://flutter.dev",
        "Flutter is beautiful",
        author: "Someone important",
        description: "TLDR: neither did I read it",
        publishedAt: DateTime.now().toUtc().toString(),
        content: null,
      );
      expect(article.isTruncated, true);
    });
    test("Article was truncated", () {
      Article article = Article(
        "https://fuchsia.dev",
        "Fuchsia is Googles new OS",
        author: "TechNerd3000",
        publishedAt: DateTime.now().toUtc().toString(),
        content:
        "This will be very short as this article has ben trunc...[+4 chars]",
      );
      expect(article.isTruncated, true);
    });
    test("Article is not truncated", () {
      Article article = Article(
        "https://github.com/flutter/flutter",
        "This is the Flutter Repo",
        author: "FlutterTeam",
        publishedAt: DateTime.now().toUtc().toString(),
        content:
        "Yay finally a Article with no truncated content",
      );
      expect(article.isTruncated, false);
    });
  });
  group("Check if Article content was cleaned", () {
    //article  content is cleaned if the content was truncated
    test("Article with content null", () {
      Article article = Article(
        "https://flutter.dev",
        "Flutter is beautiful",
        author: "Someone important",
        description: "TLDR: neither did I read it",
        publishedAt: DateTime.now().toUtc().toString(),
        content: null,
      );
      expect(article.cleanContent, "Lese den ganzen Artikel auf der Website");
    });
    test("Article was truncated", () {
      Article article = Article(
        "https://fuchsia.dev",
        "Fuchsia is Googles new OS",
        author: "TechNerd3000",
        publishedAt: DateTime.now().toUtc().toString(),
        content:
        "This will be very short as this article has ben trunc...[+4 chars]",
      );
      expect(article.cleanContent, "This will be very short as this article has ben trunc...");
    });
    test("Article is not truncated", () {
      Article article = Article(
        "https://github.com/flutter/flutter",
        "This is the Flutter Repo",
        author: "FlutterTeam",
        publishedAt: DateTime.now().toUtc().toString(),
        content:
        "Yay finally a Article with no truncated content",
      );
      expect(article.cleanContent, article.content);
    });
  });
  group("Check if the domain is correct", () {
    //domain is the url parts between // and the first following /
    //the url may not be malformed as this would impose that the API is broken.
    test("Check if Domain is correctly extracted from namespace url", () {
      Article article = Article(
        "https://github.com/flutter/flutter.git",
        "Flutter is beautiful",
        publishedAt: DateTime.now().toUtc().toString(),
      );
      expect(article.domain, "github.com");
    });
    test("Check if Domain is correctly extracted from ip url", () {
      Article article = Article(
        "http://127.0.0.1/index.html",
        "Fuchsia is Googles new OS",
      );
      expect(article.domain, "127.0.0.1");
    });
  });
  group("Check if the time is correct", () {
    //time is to displayed in format dd.mm.yyyy hh:mm
    test("Check if time is correctly displayed", () {
      Article article = Article(
        "https://github.com/flutter/flutter.git",
        "Flutter is beautiful",
        publishedAt: DateTime.utc(2020).toString(),
      );
      expect(article.time, "01.01.2020 00:00");
    });
  });
}

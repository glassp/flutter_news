import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_news/models/AppState.dart';
import 'package:flutter_news/models/Article.dart';
import 'package:http/http.dart' as http;

///The Action that runs the API fetch and update3s the State with the fetched data
///Also checks if the provided API key is valid and stores that information in the state too
class FetchAction extends ReduxAction<AppState> {
  final String _apiKey;
  final String _country;
  FetchAction():this._apiKey="",this._country="";
  @visibleForTesting
  FetchAction.setAll(this._apiKey,this._country);

  Future<AppState> reduce() async {
    List<Article> articles = await _fetch();
    if (articles == null) {
      return state.copy(
          keyIsWorking: false,
          articleState: state.articleState.copy(articles: []));
    }
    if (articles.isEmpty) return state;
    return state.copy(
        keyIsWorking: true,
        articleState: state.articleState.copy(articles: articles));
  }

  ///fetches the data from the API
  Future<List<Article>> _fetch() async {
    String apiKey = _apiKey.isEmpty?state.settings.key:_apiKey;
    String country = _country.isEmpty?state.settings.country:_country;
    http.Response response = await http.get(
        'https://newsapi.org/v2/top-headlines?country=$country',
        headers: {HttpHeaders.authorizationHeader: "Bearer $apiKey"});
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['status'] == 'error') {
      if (json['code'] == 'apiKeyDisabled' || json['code'] == 'apiKeyInvalid')
        return null;
      debugPrint(json['message']);
      return NewsFeed().articles;
    }
    return NewsFeed.fromJson(json).articles;
  }
}

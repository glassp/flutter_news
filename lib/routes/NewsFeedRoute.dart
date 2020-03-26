import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/controller/FetchAction.dart';
import 'package:flutter_news/models/AppState.dart';
import 'package:flutter_news/models/Article.dart';
import 'package:flutter_news/models/Settings.dart';
import 'dart:ui' as ui;

import 'SettingsRoute.dart';

///the class that displays the Newsfeed
class NewsFeedRoute extends StatelessWidget {
  ///the list of news that are to be displayed
  final List<Article> newsFeed;

  ///the current settings of the app
  final Settings _settings;

  ///what action to perform when a pullToRefresh event is invoked
  final ui.VoidCallback refresh;

  ///if the apiKey is working
  final bool keyIsWorking;

  ///what to show while the newsfeed is loading
  final List<Widget> fallback = <Widget>[
    Center(child: CircularProgressIndicator())
  ];
  NewsFeedRoute(this.newsFeed, this.refresh, this._settings,
      [this.keyIsWorking = false]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NewsApp"),
          actions: <Widget>[
            if (keyIsWorking)
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsRoute(_settings))),
              ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView(children: <Widget>[
            if (keyIsWorking)
              if (newsFeed?.isEmpty ?? true) ...fallback else ...newsFeed
            else
              Column(
                children: <Widget>[
                  Text(
                    'Der API Key ist ungültig',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.redAccent),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 2.0),
                      child: RaisedButton(
                        child: Text('API Key aktuallisieren'),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SettingsRoute(_settings)),
                              (route) => !Navigator.canPop(context));
                        },
                      ))
                ],
              ),
          ]),
        ));
  }
}

class _ViewModel extends BaseModel<AppState> {
  List<Article> newsFeed;
  Settings settings;
  ui.VoidCallback onRefresh;
  bool keyIsWorking = true;

  _ViewModel();
  _ViewModel.build(
      this.newsFeed, this.onRefresh, this.settings, this.keyIsWorking) {
    debugPrint(keyIsWorking.toString());
  }

  @override
  BaseModel fromStore() => _ViewModel.build(
      state.articleState.articles,
      () => dispatchFuture(FetchAction()),
      state.settings,
      state.keyIsWorking);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is _ViewModel &&
          runtimeType == other.runtimeType &&
          settings == other.settings &&
          keyIsWorking == other.keyIsWorking &&
          newsFeed == other.newsFeed;

  @override
  int get hashCode =>
      super.hashCode ^ newsFeed.hashCode ^ keyIsWorking.hashCode;
}

class NewsFeedConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      model: _ViewModel(),
      debug: this,
      rebuildOnChange: true,
      onDidChange: (vm) => vm.fromStore(),
      onInit: (store) =>
          store.dispatchFuture(FetchAction()),
      builder: (BuildContext context, _ViewModel vm) => NewsFeedRoute(
          vm.newsFeed, vm.onRefresh, vm.settings, vm.keyIsWorking),
    );
  }
}

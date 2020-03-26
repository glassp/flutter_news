import 'package:flutter_news/models/ArticleState.dart';
import 'package:flutter_news/models/Settings.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AppState.g.dart';

@JsonSerializable(nullable: false)

///The representation of the Appstate
class AppState {
  final ArticleState articleState;
  final Settings settings;
  final bool keyIsWorking;

  AppState({this.articleState, this.settings, this.keyIsWorking = true});
  factory AppState.fromJson(Map<String, dynamic> json) {
    if (json == null) return AppState.initialState();
    return _$AppStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  AppState copy(
      {ArticleState articleState,
      Settings settings,
      bool keyIsWorking = true}) {
    return AppState(
        articleState: articleState ?? this.articleState,
        settings: settings ?? this.settings,
        keyIsWorking: keyIsWorking);
  }

  static AppState initialState() => AppState(
      articleState: ArticleState.initialState(),
      settings: Settings.initialState(),
      keyIsWorking: false);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          articleState == other.articleState &&
          settings == other.settings &&
          keyIsWorking == other.keyIsWorking;

  @override
  int get hashCode =>
      articleState.hashCode ^ settings.hashCode ^ keyIsWorking.hashCode;
}

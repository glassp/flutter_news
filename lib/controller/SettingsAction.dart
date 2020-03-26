import 'package:async_redux/async_redux.dart';
import 'package:flutter_news/models/AppState.dart';
import 'package:flutter_news/models/Settings.dart';

///The Action that updates the Settings
class SettingsAction extends ReduxAction<AppState> {
  Settings settings;

  SettingsAction(this.settings);
  AppState reduce() {
    return state.copy(settings: this.settings);
  }
}

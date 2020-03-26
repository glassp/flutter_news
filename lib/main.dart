import 'dart:ui';

import 'package:async_redux/async_redux.dart';
import 'package:flutter_news/models/AppPersistor.dart';
import 'package:flutter_news/models/AppState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/routes/NewsFeedRoute.dart';
import 'package:flutter_news/routes/SettingsRoute.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppPersistor persistor = AppPersistor();
  var startupState = await persistor.readState();

  if (startupState == null) {
    var startupState = AppState.initialState();
    await persistor.saveInitialState(startupState);
  }
  Store<AppState> store = Store<AppState>(
      initialState: startupState,
      persistor: persistor,
      modelObserver: DefaultModelObserver());

  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        darkTheme: ThemeData(brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
        title: "NewsApp",
        home: store.state.settings.key == null
            ? SettingsRoute(store.state.settings)
            : NewsFeedConnector(),
      ),
    );
  }
}

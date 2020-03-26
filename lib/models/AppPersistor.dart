import 'dart:async';
import 'dart:convert';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_news/models/AppState.dart';

///The class that is responsible for storing the AppState each time the State changed
class AppPersistor extends Persistor<AppState> {
  final LocalPersist fileHandler = LocalPersist("appState");

  @override
  Future<void> deleteState() async {
    await fileHandler.delete();
  }

  @override
  Future<void> persistDifference(
      {AppState lastPersistedState, AppState newState}) async {
    await deleteState();
    await fileHandler.save([jsonEncode(newState.toJson())]);
  }

  @override
  Future<AppState> readState() async {
    List<Object> obj = await fileHandler.load();
    if (obj == null || obj.first == null) return null;
    print(obj.runtimeType.toString());
    print(obj.first.runtimeType.toString());
    print(jsonDecode(obj.first).runtimeType.toString());
    return AppState.fromJson(jsonDecode(obj.first));
  }
}

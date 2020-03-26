import 'package:async_redux/async_redux.dart';
import 'package:flutter_news/controller/SettingsAction.dart';
import 'package:flutter_news/models/AppState.dart';
import 'package:flutter_news/models/Settings.dart';
import 'package:test/test.dart';

//We only need to check if the settings were overriden
void main(){
  test("Check if settings have changed", ()async{
    var store = Store<AppState>(initialState: AppState.initialState());
    var storeTester = StoreTester<AppState>.from(store);
    var settings = Settings('ThisIsOurSUperAwesomeApiKey',country: 'us');
    storeTester.dispatch(SettingsAction(settings));
    TestInfo<AppState> info = await storeTester.wait(SettingsAction);
    expect(info.state.settings.key==null, false);
    expect(info.state.settings.key, 'ThisIsOurSUperAwesomeApiKey');
    expect(info.state.settings.country, 'us');
  });
}
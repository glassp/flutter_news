import 'package:async_redux/async_redux.dart';
import 'package:flutter_news/controller/FetchAction.dart';
import 'package:flutter_news/models/AppState.dart';
import 'package:dotenv/dotenv.dart';
import 'package:test/test.dart';

//There are only 2 relevant cases from 4 total cases to check
//checking if the key is valid
//checking if we got data
//First case to check: key is valid and we got data
//Second case to check: key is invalid and we got no data
//Third case we could check is if the key is valid and we got no data but in that case we would not mutate our state and just return the state from before the action was called
//The fouth case is impossible we will never get data if our key is invalid.
void main(){
  load();
  test("Check if valid key gives us data", ()async{

    var store = Store<AppState>(initialState: AppState.initialState());
    var storeTester = StoreTester<AppState>.from(store);
    storeTester.dispatchFuture(FetchAction.setAll(env['NEWSAPI_KEY'],"de"));
    TestInfo<AppState> info = await storeTester.wait(FetchAction);
    expect(info.state.keyIsWorking, true);
    expect(info.state.articleState.articles!=null, true);
    expect(info.state.articleState.articles.isEmpty??true, false);
  });
  test("Check if invalid key tells us if its invalid", ()async{
    var store = Store<AppState>(initialState: AppState.initialState());
    var storeTester = StoreTester<AppState>.from(store);
    storeTester.dispatchFuture(FetchAction.setAll('ThisIsOurSUperAwesomeApiKey',"de"));
    TestInfo<AppState> info = await storeTester.wait(FetchAction);
    expect(info.state.keyIsWorking, false);
    expect(info.state.articleState.articles!=null, true);
    expect(info.state.articleState.articles.isEmpty, true);
  });
}
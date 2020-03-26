import 'package:async_redux/async_redux.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_news/controller/SettingsAction.dart';
import 'package:flutter_news/models/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/routes/NewsFeedRoute.dart';

///The Route used to change the Settings
class SettingsRoute extends StatefulWidget {
  final Settings settings;

  SettingsRoute(this.settings);

  @override
  State<StatefulWidget> createState() => _SettingsState(this.settings);
}

///The current State of the SettingsRoute
class _SettingsState extends State<SettingsRoute> {
  ///The settings of the App
  Settings _settings;

  ///A key to determin the current state of the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _SettingsState(this._settings);
  @override
  Widget build(BuildContext context) {
    var dropdownMenuItems = <DropdownMenuItem<String>>[
      DropdownMenuItem(
        value: 'de',
        child: Text("Deutschland"),
      ),
      DropdownMenuItem(
        value: 'us',
        child: Text("USA"),
      ),
      DropdownMenuItem(
        value: 'gb',
        child: Text("England"),
      ),
      DropdownMenuItem(
        value: 'pt',
        child: Text("Portugal"),
      ),
      DropdownMenuItem(
        value: 'mx',
        child: Text("Mexico"),
      ),
      DropdownMenuItem(
        value: 'fr',
        child: Text("Frankreich"),
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text("Einstellungen"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'API Key'),
                initialValue: _settings.key ?? "",
                onChanged: (String value) {
                  setState(() {
                    _settings = _settings.copy(
                        settings: Settings(value, country: _settings.country));
                  });
                },
                validator: (String value) {
                  if (value?.isEmpty ?? true)
                    return "Der API key wird benötigt um die News anzuzeigen. Er wird natürlich vertraulich behandelt.";
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "Land"),
                value: _settings.country,
                items: dropdownMenuItems,
                onChanged: (String value) {
                  setState(() {
                    _settings = _settings.copy(
                        settings: Settings(_settings.key, country: value));
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: MaterialButton(
                    child: Text("Speichern"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        debugPrint("saving...");
                        debugPrint(this._settings.toJson().toString());
                        StoreProvider.dispatchFuture(
                            context, SettingsAction(this._settings));
                        Flushbar(
                          message: 'Einstellungen wurden gespeichert',
                          duration: Duration(seconds: 1),
                          flushbarStyle: FlushbarStyle.FLOATING,
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          icon: Icon(Icons.info),
                          margin: EdgeInsets.all(8.0),
                          borderRadius: 8.0,
                          leftBarIndicatorColor: Colors.blueAccent,
                        )..show(context);
                        Future.delayed(Duration(seconds: 1), () {
                          if (Navigator.canPop(context)) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsFeedConnector()),
                                (route) => !Navigator.canPop(context));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsFeedConnector()));
                          }
                        });
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

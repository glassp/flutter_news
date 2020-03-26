import 'package:json_annotation/json_annotation.dart';
part 'Settings.g.dart';

@JsonSerializable(nullable: false)

///the Settings of the App as a AppState
class Settings {
  final String key;
  final String country;

  Settings(this.key, {this.country = "de"});
  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  Settings copy({Settings settings}) => Settings(settings.key ?? this.key,
      country: settings.country ?? this.country);
  static Settings initialState() => Settings(null);
}

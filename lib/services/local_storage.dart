import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._();

  //key storage
  static const String acToken = 'access_token';

  SharedPreferences? pref;

  SharedPreferences get store => pref!;

  LocalStorage._();

  factory LocalStorage() => _instance;

  static LocalStorage get instance => _instance;

  String get token => store.getString(LocalStorage.acToken) ?? '';

  static Future<void> init() async {
    instance.pref ??= await SharedPreferences.getInstance();
    return Future.value();
  }

  setToken(String token) {
    return store.setString(acToken, token);
  }
}

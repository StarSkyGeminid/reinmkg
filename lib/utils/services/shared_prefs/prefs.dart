import 'package:shared_preferences/shared_preferences.dart';


class MainBoxK {
  MainBoxK._();
}

enum MainPrefsKeys {
  theme,
  locale,
  location,
  coordinate,
  measurementUnit,
}

mixin class MainPrefsMixin {
  static late SharedPreferences? prefs;

  static Future<void> initSharedPrefs(String prefixBox) async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> addData<T>(MainPrefsKeys key, T value) async {
    if (value is bool) {
      return prefs!.setBool(key.name, value as bool);
    } else if (value is int) {
      return prefs!.setInt(key.name, value as int);
    } else if (value is double) {
      return prefs!.setDouble(key.name, value as double);
    } else if (value is String) {
      return prefs!.setString(key.name, value as String);
    }

    throw Exception();
  }

  Future<bool> replaceData<T>(MainPrefsKeys key, T value) async {
    return removeData(key).then((_) {
      return addData(key, value);
    });
  }

  Future<void> removeData(MainPrefsKeys key) async {
    await prefs?.remove(key.name);
  }

  T? getData<T>(MainPrefsKeys key) => prefs?.get(key.name) as T?;
}

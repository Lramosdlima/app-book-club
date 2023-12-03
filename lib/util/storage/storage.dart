import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static SharedPreferences _prefs = StorageHelper._prefs;

  static Future _getInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() async {
    await _getInstance();
    return _prefs.clear();
  }

  static Future<int?> getInt(String key) async {
    await _getInstance();
    return _prefs.getInt(key);
  }

  static Future<String?> get(String key) async {
    await _getInstance();
    return _prefs.getString(key);
  }

  static void setInt(String key, int value) async {
    await _getInstance();
    _prefs.setInt(key, value);
  }

  static void set(String key, dynamic value) async {
    await _getInstance();
    _prefs.setString(key, value);
  }

  static void setList(String key, List<String> value) async {
    await _getInstance();
    _prefs.setStringList(key, value);
  }

  static Future<List<String>?> getList(String key) async {
    await _getInstance();
    return _prefs.getStringList(key);
  }

  static void remove(String key) async {
    _getInstance();
    _prefs.remove(key);
  }
}

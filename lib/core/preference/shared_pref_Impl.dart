import 'package:githubjobs/core/preference/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefImpl implements SharedPref {
  SharedPreferences _prefs;

  @override
  Future<void> clearPreference() async {
    _prefs ??= await SharedPreferences.getInstance();
    _prefs.clear();
  }

  @override
  Future<void> putInt(String key, int value) async {
    _prefs ??= await SharedPreferences.getInstance();
    assert(key?.trim()?.isEmpty ?? false, '`key` cannot be null or empty');
    await _prefs.setInt(key, value);
  }

  @override
  Future<void> putString(String key, String value) async {
    _prefs ??= await SharedPreferences.getInstance();
    assert(key?.trim()?.isEmpty ?? false, '`key` cannot be null or empty');
    await _prefs.setString(key, value);
  }

  @override
  Future<void> putBool(String key, bool value) async {
    _prefs ??= await SharedPreferences.getInstance();
    assert(key?.trim()?.isEmpty ?? false, '`key` cannot be null or empty');
    await _prefs.setBool(key, value);
  }

  @override
  Future<void> putDouble(String key, double value) async {
    _prefs ??= await SharedPreferences.getInstance();
    assert(key != null || key.trim().isEmpty, '`key` cannot be null or empty');
    await _prefs.setDouble(key, value);
  }

  @override
  Future<bool> getBool(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    assert(key?.trim()?.isEmpty ?? false, '`key` cannot be null or empty');
    return _prefs.getBool(key);
  }

  @override
  Future<double> getDouble(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    assert(key?.trim()?.isEmpty ?? false, '`key` cannot be null or empty');
    return _prefs.getDouble(key);
  }

  @override
  Future<int> getInt(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    assert(key != null || key.trim().isEmpty, '`key` cannot be null or empty');
    return _prefs.getInt(key);
  }

  @override
  Future<String> getString(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    assert(key?.trim()?.isEmpty ?? false, '`key` cannot be null or empty');
    return _prefs.getString(key);
  }
}

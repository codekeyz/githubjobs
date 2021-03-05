abstract class SharedPref {
  Future<void> putString(String key, String value);

  Future<void> putInt(String key, int value);

  Future<void> putBool(String key, bool value);

  Future<void> putDouble(String key, double value);

  Future<String> getString(String key);

  Future<int> getInt(String key);

  Future<bool> getBool(String key);

  Future<double> getDouble(String key);

  Future<void> clearPreference();
}

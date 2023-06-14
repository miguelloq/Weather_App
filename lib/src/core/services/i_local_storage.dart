abstract interface class ILocalStorage{
  Future<String> getString(String key);
  Future<void> setString(String key, String input);
  Future<void> remove(String key);
}
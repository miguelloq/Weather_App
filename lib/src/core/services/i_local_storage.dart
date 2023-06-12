abstract interface class ILocalStorage{
  String getString(String key);
  void setString(String key, String input);
  void remove(String key);
}
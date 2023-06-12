import 'i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements ILocalStorage {
  final SharedPreferences prefs;
  SharedPreferencesService(this.prefs);

  @override
  String getString(String key){
    return prefs.getString(key) ?? '';
  }

  @override
  void setString(String key, String input) async {
    await prefs.setString(key, input);
  }

  @override
  void remove(String key) async{
    await prefs.remove(key);
  }
}

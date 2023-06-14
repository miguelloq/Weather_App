import 'i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements ILocalStorage {

  @override
  Future<String> getString(String key) async{
    var prefs= await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  @override
  Future<void> setString(String key, String input) async {
    var prefs= await SharedPreferences.getInstance();
    await prefs.setString(key, input);
  }

  @override
  Future<void> remove(String key) async{
    var prefs= await SharedPreferences.getInstance();
    await prefs.remove(key); 
  }
}

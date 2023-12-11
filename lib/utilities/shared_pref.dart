import 'package:shared_preferences/shared_preferences.dart';


Future<void> saveData(String key, {String? str, int? num, bool? boo}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(str != null){
    prefs.setString(key, str);
  }
  if(num != null){
    prefs.setInt(key, num);
  }
  if(boo != null){
    prefs.setBool(key, boo);
  }
}Future<String?> getString(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
Future<void> removeString(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

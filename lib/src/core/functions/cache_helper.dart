import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static late SharedPreferences sharedPreferences ;
  static  init() async
  {
    sharedPreferences = await SharedPreferences.getInstance() ;
  }
// ********************
  static dynamic getData({
    required dynamic key ,
  })
  {
    return  sharedPreferences.get(key) ;
  }
  // ********************
  static dynamic save ;
  static Future<bool> saveData({
    required String key ,
    required dynamic value ,
  }) async
  {
    if(value is String) save = await sharedPreferences.setString(key, value);
    if(value is int) save = await sharedPreferences.setInt(key, value);
    if(value is bool) save = await sharedPreferences.setBool(key, value);
    if(value is double) save = await sharedPreferences.setDouble(key, value);
    return save ;

  }

  // ********************

  static Future<bool> removeData ({
    required dynamic key ,
  })async
  {
    return await sharedPreferences.remove(key);
  }

}
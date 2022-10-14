import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {



  static late final SpUtil instance = SpUtil._internal();

  factory SpUtil() => instance;

  static late SharedPreferences prefs;

  SpUtil._internal()   {
    init();
  }


  static Future<SharedPreferences> init() async {
    print("init初始化");
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  /// put object.
  static Future<bool> putObject(String key, Object value) async {
    return prefs.setString(key, json.encode(value));
  }

  /// get object.
  static Map? getObject(String key) {
    String? _data = prefs.getString(key);
    return json.decode(_data ?? "");
  }

  /// get object.
  static Object getObject2(String key) {
    String _data = prefs.getString(key) ?? "";
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  /// put object list.
  static Future<bool> putObjectList(String key, List<Object> list) {
    List<String>  _dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    return prefs.setStringList(key, _dataList );
  }

  /// get object list.
  static List<Map>? getObjectList(String key) {
    List<String> dataLis = prefs.getStringList(key) ?? [];
    return dataLis.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    }).toList();
  }

  /// get string.
  static String getString(String key, {String defValue = ''}) {
    if (prefs == null) return defValue;
    return prefs.getString(key) ?? defValue;
  }

  /// put string.
  static Future<bool> putString(String key, String? value) {
    return prefs.setString(key, value??"");
  }

  /// get bool.
  static  bool  getBool(String key, {bool defValue = false}) {
      return prefs.getBool(key) ?? defValue;
  }

  /// put bool.
  static Future<bool> putBool(String key, bool? value) {
    return prefs.setBool(key, value??false);
  }

  /// get int.
  static int getInt(String key, {int defValue = 0}) {
    if (prefs == null) return defValue;
    return prefs.getInt(key) ?? defValue;
  }

  /// put int.
  static Future<bool> putInt(String key, int? value) {
    return prefs.setInt(key, value??0);
  }

  /// get double.
  static double getDouble(String key, double defValue) {
    if (prefs == null) return defValue;
    return prefs.getDouble(key) ?? defValue;
  }

  /// put double.
  static Future<bool> putDouble(String key, double value) {
    return prefs.setDouble(key, value);
  }

  /// get string list.
  static List<String> getStringList(String key,
      {List<String> defValue = const []}) {
    if (prefs == null) return defValue;
    return prefs.getStringList(key) ?? defValue;
  }

  /// put string list.
  static Future<bool> putStringList(String key, List<String> value) {
    return prefs.setStringList(key, value);
  }

  /// get dynamic.
  static dynamic getDynamic(String key, {Object? defValue}) {
    if (prefs == null) return defValue;
    return prefs.get(key) ?? defValue;
  }

  /// have key.
  static bool haveKey(String key) {
    return prefs.getKeys().contains(key);
  }

  /// get keys.
  static Set<String> getKeys() {
    return prefs.getKeys();
  }

  /// remove.
  static Future<bool> remove(String key) {
    return prefs.remove(key);
  }

  /// clear.
  static Future<bool> clear() {
    return prefs.clear();
  }

  ///Sp is initialized.
  static bool isInitialized() {
    return prefs != null;
  }
}

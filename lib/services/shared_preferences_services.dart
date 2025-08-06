import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> saveAbsensiHistory(
      List<Map<String, dynamic>> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('absensi_history', jsonEncode(data));
  }

  static Future<List<Map<String, dynamic>>> getAbsensiHistory() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('absensi_history');
    if (jsonString == null) return [];
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.cast<Map<String, dynamic>>();
  }

  static Future<void> clearAbsensiHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('absensi_history');
  }
}

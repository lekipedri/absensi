import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/riwayat_absensi_model.dart';

class AbsensiStorageService {
  static const String _key = 'riwayatAbsensi';

  static Future<void> simpanAbsensi(RiwayatAbsensiModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final listString = prefs.getStringList(_key) ?? [];
    listString.add(jsonEncode(data.toJson()));
    await prefs.setStringList(_key, listString);
  }

  static Future<List<RiwayatAbsensiModel>> getRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    final listString = prefs.getStringList(_key) ?? [];

    return listString.map((item) {
      final jsonData = jsonDecode(item);
      return RiwayatAbsensiModel.fromJson(jsonData);
    }).toList();
  }

  static Future<void> hapusSemua() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import '../model/riwayat_absensi_model.dart';
import '../services/absensi_service.dart';

class RiwayatAbsensiPage extends StatefulWidget {
  const RiwayatAbsensiPage({super.key});

  @override
  State<RiwayatAbsensiPage> createState() => _RiwayatAbsensiPageState();
}

class _RiwayatAbsensiPageState extends State<RiwayatAbsensiPage> {
  List<RiwayatAbsensiModel> riwayat = [];

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  Future<void> _muatData() async {
    final data = await AbsensiStorageService.getRiwayat();
    setState(() {
      riwayat = data.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Absensi')),
      body: riwayat.isEmpty
          ? const Center(child: Text("Belum ada riwayat absen"))
          : ListView.builder(
              itemCount: riwayat.length,
              itemBuilder: (context, index) {
                final item = riwayat[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.file(
                      File(item.selfiePath),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text('${item.tanggal} - ${item.waktu}'),
                    subtitle: Text('Lokasi: ${item.statusLokasi}'),
                  ),
                );
              },
            ),
    );
  }
}

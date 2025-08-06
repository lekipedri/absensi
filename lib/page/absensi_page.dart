import 'dart:io';
import 'package:absensiapp/page/riwayat_absensi_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import '../model/riwayat_absensi_model.dart';
import '../services/absensi_service.dart';
import '../services/shared_preferences_services.dart';
import '../utilis/location_utils.dart';
import '../utilis/permission_handler.dart';

class AbsensiPage extends StatefulWidget {
  final String namaUser;

  const AbsensiPage({super.key, required this.namaUser});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  LatLng? userLocation;
  bool sudahAbsen = false;
  File? selfieFile;

  LatLng kantor = LatLng(37.4219983, -122.084);

  @override
  void initState() {
    super.initState();
    initAbsensi();
  }

  Future<void> initAbsensi() async {
    bool granted = await PermissionUtils.requestLocationAndCamera();
    if (!granted) return;

    userLocation = await LocationUtils.getCurrentLocation();
    bool absenStatus = await SharedPrefService.getBool('sudahAbsen') ?? false;
    String? path = await SharedPrefService.getString('selfiePath');

    if (path != null) selfieFile = File(path);
    setState(() {
      sudahAbsen = absenStatus;
    });
  }

  Future<void> ambilSelfie() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.camera);
    if (result != null) {
      selfieFile = File(result.path);
      await SharedPrefService.saveString('selfiePath', selfieFile!.path);
      setState(() {});
    }
  }

  Future<void> simpanAbsensi() async {
    double jarakMeter = LocationUtils.hitungJarakMeter(
      userLocation!.latitude,
      userLocation!.longitude,
      kantor.latitude,
      kantor.longitude,
    );

    if (jarakMeter > 100) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Lokasi Tidak Valid"),
          content: const Text("Anda berada di luar wilayah kantor."),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"))
          ],
        ),
      );
      return;
    }

    final data = RiwayatAbsensiModel(
      tanggal: DateTime.now().toString().split(' ')[0],
      waktu: TimeOfDay.now().format(context),
      statusLokasi: jarakMeter <= 100 ? 'Valid' : 'Tidak Valid',
      selfiePath: selfieFile!.path,
    );

    await AbsensiStorageService.simpanAbsensi(data);

    setState(() {
      sudahAbsen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halo, ${widget.namaUser}"), actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RiwayatAbsensiPage(),
                ),
              );
            },
            icon: const Icon(Icons.history))
      ]),
      body: Column(
        children: [
          Expanded(
            child: userLocation == null
                ? const Center(child: CircularProgressIndicator())
                : FlutterMap(
                    options: MapOptions(initialCenter: kantor, initialZoom: 16),
                    children: [
                      TileLayer(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: const ['a', 'b', 'c']),
                      CircleLayer(circles: [
                        CircleMarker(
                          point: kantor,
                          color: Colors.blue.withOpacity(0.2),
                          radius: 100,
                          useRadiusInMeter: true,
                        ),
                      ]),
                      MarkerLayer(markers: [
                        Marker(
                          point: kantor,
                          width: 80,
                          height: 80,
                          child: const Icon(Icons.location_on,
                              color: Colors.red, size: 35),
                        ),
                        Marker(
                          point: userLocation!,
                          width: 80,
                          height: 80,
                          child: const Icon(Icons.person_pin_circle,
                              color: Colors.blue, size: 35),
                        ),
                      ]),
                    ],
                  ),
          ),
          const SizedBox(height: 10),
          Text(
              " Lokasi: ${userLocation?.latitude}, ${userLocation?.longitude}"),
          Text(" Status: ${sudahAbsen ? "Sudah absen" : "Belum absen"}"),
          if (selfieFile != null) Image.file(selfieFile!, height: 100),
          ElevatedButton(
              onPressed: ambilSelfie, child: const Text("Ambil Selfie")),
          ElevatedButton(
            onPressed: sudahAbsen || selfieFile == null ? null : simpanAbsensi,
            child: const Text("Absen Sekarang"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await SharedPrefService.saveBool('sudahAbsen', false);
              await SharedPrefService.saveString('selfiePath', '');
              await SharedPrefService.saveString('absenTime', '');
              setState(() {
                sudahAbsen = false;
                selfieFile = null;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data absen berhasil dihapus')),
              );
            },
            child: const Text("Hapus Data Absen"),
          ),
        ],
      ),
    );
  }
}

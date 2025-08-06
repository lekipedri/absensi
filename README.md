#  Aplikasi Absensi Flutter

Aplikasi mobile absensi berbasis Flutter yang memanfaatkan validasi lokasi dan selfie kamera sebagai bukti kehadiran. Cocok untuk kebutuhan absensi karyawan, pegawai, atau mahasiswa.

##  Fitur Utama

-  **Validasi Lokasi**  
  Menggunakan plugin `geolocator`, aplikasi memverifikasi apakah pengguna berada dalam radius 100 meter dari lokasi kantor.

-  **Dokumentasi Selfie**  
  Pengguna harus mengambil selfie sebelum melakukan absensi.

-  **Peta Lokasi**  
  Menampilkan lokasi pengguna dan kantor menggunakan plugin `flutter_map`.

-  **Riwayat Absensi**  
  Menyimpan riwayat absensi lokal:
  - Tanggal & waktu
  - Status lokasi (valid / tidak valid)
  - Thumbnail selfie

-  **Penyimpanan Lokal**  
  Semua data disimpan menggunakan `SharedPreferences`, tanpa backend/API.

##  Teknologi

- Flutter
- Dart
- Shared Preferences
- Geolocator
- Flutter Map
- Image Picker
- Permission Handler
- latlong2

## 🚀 Cara Menjalankan
```bash
flutter pub get
flutter run
```


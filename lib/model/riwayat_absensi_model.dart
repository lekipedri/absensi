class RiwayatAbsensiModel {
  final String tanggal;
  final String waktu;
  final String statusLokasi;
  final String selfiePath;

  RiwayatAbsensiModel({
    required this.tanggal,
    required this.waktu,
    required this.statusLokasi,
    required this.selfiePath,
  });

  factory RiwayatAbsensiModel.fromJson(Map<String, dynamic> json) {
    return RiwayatAbsensiModel(
      tanggal: json['tanggal'],
      waktu: json['waktu'],
      statusLokasi: json['statusLokasi'],
      selfiePath: json['selfiePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal,
      'waktu': waktu,
      'statusLokasi': statusLokasi,
      'selfiePath': selfiePath,
    };
  }
}

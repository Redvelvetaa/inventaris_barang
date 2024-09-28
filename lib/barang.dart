class Barang {
  final int kodeBarang;
  final String namaBarang;
  final String jenisBarang;
  final String merk;
  final String keadaan;
  final int tahunMasuk;
  final int jumlahBarang;
  final String status;
  Barang({
    required this.kodeBarang,
    required this.namaBarang,
    required this.jenisBarang,
    required this.merk,
    required this.keadaan,
    required this.tahunMasuk,
    required this.jumlahBarang,
    required this.status,
  });
  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      kodeBarang: json['kode_barang'] != null
          ? int.tryParse(json['kode_barang'].toString()) ?? 0
          : 0,
      namaBarang: json['nama_barang'] ?? 'Unknown',
      jenisBarang: json['jenis_barang'] ?? 'Unknown',
      merk: json['merk'] ?? 'Unknown',
      keadaan: json['keadaan'] ?? 'Unknown',
      tahunMasuk: json['tahun_masuk'] != null
          ? int.tryParse(json['tahun_masuk'].toString()) ?? 0
          : 0,
      jumlahBarang: json['jumlah_barang'] != null
          ? int.tryParse(json['jumlah_barang'].toString()) ?? 0
          : 0,
      status: json['status'] ?? 'Unknown',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'kode_barang': kodeBarang,
      'nama_barang': namaBarang,
      'jenis_barang': jenisBarang,
      'merk': merk,
      'keadaan': keadaan,
      'tahun_masuk': tahunMasuk,
      'jumlah_barang': jumlahBarang,
      'status': status,
    };
  }
}

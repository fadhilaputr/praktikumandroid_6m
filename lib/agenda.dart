class Agenda {
  final int? id;
  final String judul;
  final String keterangan;
  final String penulis; // ✅ Tambahkan properti penulis

  Agenda({
    this.id,
    required this.judul,
    required this.keterangan,
    required this.penulis, // ✅ Tambahkan ke konstruktor
  });

  factory Agenda.fromJson(Map<String, dynamic> json) {
    return Agenda(
      id: json['id'],
      judul: json['judul'],
      keterangan: json['keterangan'],
      penulis: json['penulis'] ?? '', // ✅ Ambil dari JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'keterangan': keterangan,
      'penulis': penulis, // ✅ Tambahkan ke JSON
    };
  }
}

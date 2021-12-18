import 'dart:convert';

String quranToJson(Quran data) => json.encode(data.toJson());
List<Quran> quranFromJson(String str) =>
    List<Quran>.from(json.decode(str).map((x) => Quran.fromJson(x)));

class Quran {
  Quran({
    this.nomor,
    this.nama,
    this.asma,
    this.name,
    this.start,
    this.ayat,
    this.type,
    this.urut,
    this.rukuk,
    this.arti,
    this.keterangan,
  });

  String? nomor;
  String? nama;
  String? asma;
  String? name;
  String? start;
  String? ayat;
  String? type;
  String? urut;
  String? rukuk;
  String? arti;
  String? keterangan;

  factory Quran.fromJson(Map<String, dynamic> json) => Quran(
        nomor: json["nomor"],
        nama: json["nama"],
        asma: json["asma"],
        name: json["name"],
        start: json["start"],
        ayat: json["ayat"],
        urut: json["urut"],
        rukuk: json["rukuk"],
        arti: json["arti"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "asma": asma,
        "name": name,
        "start": start,
        "ayat": ayat,
        "urut": urut,
        "rukuk": rukuk,
        "arti": arti,
        "keterangan": keterangan,
      };
}

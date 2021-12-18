class Ayat {
  Ayat({
    this.id,
    this.surat,
    this.ayat,
    this.teks,
  });

  String? id;
  String? surat;
  String? ayat;
  String? teks;

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        id: json["id"],
        surat: json["surat"],
        ayat: json["ayat"],
        teks: json["teks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "surat": surat,
        "ayat": ayat,
        "teks": teks,
      };
}

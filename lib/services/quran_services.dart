import 'dart:convert';
import 'package:flutter_audio_player/model/audio.dart';
import 'package:flutter_audio_player/model/ayat.dart';
import 'package:flutter_audio_player/model/quran.dart';
import 'package:http/http.dart' as http;

String baseUrl = "https://api.banghasan.com/";

class QuranServices {
  static Future<List<Quran>> getSurah() async {
    var url = Uri.parse("https://api.banghasan.com/quran/format/json/surat");

    var respons = await http.get(url);
    List<Quran> _result = [];
    if (respons.statusCode == 200) {
      var data = jsonDecode(utf8.decode(respons.bodyBytes));
      List<Quran> surahs =
          (data['hasil'] as Iterable).map((e) => Quran.fromJson(e)).toList();
      _result.addAll(surahs);
      // print(surahs);
      return _result;
    } else {
      return _result;
    }
  }

  static Future<List<Ayat>> getAyat(
    int noSurat,
    int ayatStart,
    int ayatEnd,
  ) async {
    var url = Uri.parse(
        "https://api.banghasan.com/quran/format/json/surat/$noSurat/ayat/$ayatStart-$ayatEnd");
    var respons = await http.get(url);
    List<Ayat> _result = [];
    if (respons.statusCode == 200) {
      var data = jsonDecode(utf8.decode(respons.bodyBytes));
      List<Ayat> ayats = (data['ayat']['data']['ar'] as Iterable)
          .map((e) => Ayat.fromJson(e))
          .toList();
      _result.addAll(ayats);
      return _result;
    } else {
      return _result;
    }
  }

  static Future<List<Verse>> getAyatv2(
    int noSurat,
  ) async {
    var url = Uri.parse("https://api.quran.sutanlab.id/surah/$noSurat");
    var respons = await http.get(url);
    List<Verse> _result = [];
    if (respons.statusCode == 200) {
      var data = jsonDecode(utf8.decode(respons.bodyBytes));
      List<Verse> ayats = (data['data']['verses'] as Iterable)
          .map((e) => Verse.fromJson(e))
          .toList();
      _result.addAll(ayats);
      // ignore: avoid_print
      print(_result);
      return _result;
    } else {
      return _result;
    }
  }
}

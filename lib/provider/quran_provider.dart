// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_player/model/audio.dart';
import 'package:flutter_audio_player/model/quran.dart';
import 'package:flutter_audio_player/services/quran_services.dart';

class QuranProvider with ChangeNotifier {
  List<Quran> _data = [];
  List<Quran> get quran => _data;
  bool isLoading = false;

  final List<Verse> verses = [];

  Future<void> getData() async {
    try {
      List<Quran> ayats = await QuranServices.getSurah();
      _data = ayats;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getVerses(int surah) async {
    isLoading = true;
    notifyListeners();
    await QuranServices.getAyatv2(surah).then((value) {
      if (value.isNotEmpty) {
        verses.clear();
        verses.addAll(value);
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }
}

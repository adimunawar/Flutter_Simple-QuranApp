// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_player/model/audio.dart';
import 'package:flutter_audio_player/model/quran.dart';
import 'package:flutter_audio_player/services/quran_services.dart';

class QuranProvider with ChangeNotifier {
  List<Quran> listAyat = [];
  final List<Quran> _cacheListAyat = [];

  bool isLoading = false;
  final List<Verse> verses = [];

  final _searchQuranController = StreamController<String>.broadcast();
  Stream<String> get searchQuranStream => _searchQuranController.stream;
  Sink<String> get searchQuranSink => _searchQuranController.sink;
  TextEditingController quranController = TextEditingController();
  String _keywordQuran = "";

  QuranProvider() {
    listenSearchQuran();
    getData();
  }

  getData() async {
    isLoading = true;

    await QuranServices.getSurah().then((value) {
      if (value.isNotEmpty) {
        _cacheListAyat.clear();
        _cacheListAyat.addAll(value);
        if (_keywordQuran.isEmpty) {
          listAyat.clear();
          listAyat.addAll(value);
          isLoading = false;
          notifyListeners();
        } else {
          final resultSearch = _cacheListAyat
              .where((it) => it.nama
                  .toString()
                  .toLowerCase()
                  .contains(_keywordQuran.toLowerCase()))
              .toList();
          listAyat.clear();
          listAyat.addAll(resultSearch);
          isLoading = false;
          notifyListeners();
        }
      } else {
        _cacheListAyat.clear();
        listAyat.clear();
        isLoading = false;
        notifyListeners();
      }
    });
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

  listenSearchQuran() {
    searchQuranStream.listen((onKeyword) {
      _keywordQuran = onKeyword;
      final resultSearch = _cacheListAyat
          .where((it) => it.nama
              .toString()
              .toLowerCase()
              .contains(_keywordQuran.toLowerCase()))
          .toList();
      listAyat.clear();
      listAyat.addAll(resultSearch);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _searchQuranController.close();
    super.dispose();
  }
}

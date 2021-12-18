// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_audio_player/provider/quran_provider.dart';
import 'package:flutter_audio_player/views/screens/detail_quran.dart';
import 'package:provider/provider.dart';

class QuranList extends StatefulWidget {
  const QuranList({Key? key}) : super(key: key);
  @override
  State<QuranList> createState() => _QuranListState();
}

class _QuranListState extends State<QuranList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuranProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('List ayat'),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Consumer<QuranProvider>(builder: (context, data, _) {
              return Column(
                children: [
                  TextField(
                    controller: provider.quranController,
                    onChanged: (val) => provider.searchQuranSink.add(val),
                    decoration: InputDecoration(
                      hintText: 'Serach surah..',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          provider.quranController.clear();
                          provider.searchQuranSink.add(
                            provider.quranController.text.trim(),
                          );
                        },
                        icon: (provider.quranController.text != "")
                            ? Icon(Icons.close)
                            : Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: data.listAyat
                            .map((e) => InkWell(
                                  onTap: () {
                                    Provider.of<QuranProvider>(context,
                                            listen: false)
                                        .getVerses(int.tryParse(e.nomor!)!);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailQuran(
                                                  quran: e,
                                                )));
                                  },
                                  child: Card(
                                    color: data.listAyat.indexOf(e) % 2 == 0
                                        ? Colors.orange[50]
                                        : Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.nama!,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(e.asma!,
                                              style: TextStyle(fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              );
            })));
  }
}

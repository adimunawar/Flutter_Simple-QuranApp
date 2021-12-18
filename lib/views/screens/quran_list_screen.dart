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
    return Scaffold(
      appBar: AppBar(
        title: Text('List ayat'),
      ),
      body: FutureBuilder(
        future: Provider.of<QuranProvider>(context, listen: false).getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Consumer<QuranProvider>(builder: (context, data, _) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.quran
                      .map((e) => InkWell(
                            onTap: () {
                              Provider.of<QuranProvider>(context, listen: false)
                                  .getVerses(int.tryParse(e.nomor!)!);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailQuran(
                                            quran: e,
                                          )));
                            },
                            child: Card(
                              color: data.quran.indexOf(e) % 2 == 0
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
              );
            }),
          );
        },
      ),
    );
  }
}

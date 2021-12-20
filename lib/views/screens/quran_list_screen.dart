// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_audio_player/provider/quran_provider.dart';
import 'package:flutter_audio_player/views/screens/detail_quran.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QuranList extends StatefulWidget {
  const QuranList({Key? key}) : super(key: key);
  @override
  State<QuranList> createState() => _QuranListState();
}

class _QuranListState extends State<QuranList> {
  ScrollController? scrollController;
  bool isShowSearch = true;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.offset <=
              scrollController!.position.minScrollExtent &&
          !scrollController!.position.outOfRange) {
        setState(() {
          isShowSearch = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuranProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
          ),
          shadowColor: Colors.black12,
          // backgroundColor: Colors.pink,
          centerTitle: true,
          title: Text(
            'Al Quran',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 20, vertical: isShowSearch == true ? 20 : 0),
            child: Consumer<QuranProvider>(builder: (context, data, _) {
              return Column(
                children: [
                  if (isShowSearch)
                    TextField(
                      controller: provider.quranController,
                      onChanged: (val) => provider.searchQuranSink.add(val),
                      decoration: InputDecoration(
                        hintText: 'Search.',
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
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (val) {
                        if (val is ScrollStartNotification) {
                          setState(() {
                            isShowSearch = false;
                          });
                        }
                        return true;
                      },
                      child: SingleChildScrollView(
                        controller: scrollController,
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
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                e.nama!,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                e.asma!,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20),
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            })));
  }
}

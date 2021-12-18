import 'package:flutter/material.dart';
import 'package:flutter_audio_player/model/quran.dart';
import 'package:flutter_audio_player/provider/quran_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailQuran extends StatefulWidget {
  final Quran quran;
  const DetailQuran({Key? key, required this.quran}) : super(key: key);

  @override
  State<DetailQuran> createState() => _DetailQuranState();
}

class _DetailQuranState extends State<DetailQuran> {
  bool isShowTranlate = true;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuranProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.quran.asma!,
          style: const TextStyle(color: Colors.black),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Row(
            children: [
              Text(
                "Translate",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
              Checkbox(
                  value: isShowTranlate,
                  onChanged: (val) {
                    setState(() {
                      isShowTranlate = val!;
                    });
                  }),
            ],
          ),
        ],
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        width: double.infinity,
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (widget.quran.nama != "Al Fatihah")
                    Text(
                      "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                      style: GoogleFonts.mirza(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: provider.verses
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          e.text!.arab!,
                                          style: const TextStyle(fontSize: 20),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      if (isShowTranlate)
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              e.translation!.id!,
                                              style: GoogleFonts.poppins(
                                                  height: 1.5),
                                            ))
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_audio_player/model/quran.dart';
import 'package:flutter_audio_player/provider/quran_provider.dart';
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
        title: Text(widget.quran.asma!),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Row(
            children: [
              const Text("Translate"),
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
                    const Text(
                      "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                      style: TextStyle(fontSize: 16),
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: provider.verses
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          e.text!.arab!,
                                          style: const TextStyle(fontSize: 16),
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
                                              e.translation!.en!,
                                              style:
                                                  const TextStyle(height: 1.5),
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

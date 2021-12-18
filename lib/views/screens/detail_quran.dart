import 'package:flutter/material.dart';
import 'package:flutter_audio_player/model/quran.dart';
import 'package:flutter_audio_player/provider/quran_provider.dart';
import 'package:provider/provider.dart';

class DetailQuran extends StatelessWidget {
  final Quran quran;
  const DetailQuran({Key? key, required this.quran}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuranProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('detail Ayat'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: provider.verses
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            e.text!.arab!,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.end,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(e.translation!.id!)
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

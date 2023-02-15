import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grateful/widgets/expanded_tile.dart';

const String gratitudeInfoTitle = "🫶🏾 Practicing Gratitude is Good";
const String writingInfoTitle = "✍🏿 Writing Everyday is Great";

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late double _deviceWidth;

  String _quoteText = "Tap the bulb to get inspired";
  String _quoteAuthor = "Grateful Team";

  final Dio _dio = Dio();
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const ExpandedTile(title: gratitudeInfoTitle),
              _paddedHeartHandsEmoji(context),
              const ExpandedTile(title: writingInfoTitle),
              Padding(
                padding: EdgeInsets.all(_padding(context)),
                child: _quoteBanner(colorScheme),
              ),
              Padding(
                padding: EdgeInsets.all(_padding(context)),
                child: IconButton(
                  iconSize: (_deviceWidth * .10),
                  tooltip: "Tap the lightbulb to get inspired.",
                  onPressed:() async {
                    await _getQuote();
                  }, 
                  icon: Icon(
                    Icons.lightbulb, 
                    color: colorScheme.onPrimary,
                    semanticLabel: "Tap the lightbulb to get inspired.",
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Padding _paddedHeartHandsEmoji(BuildContext context) {
    return Padding(
              padding: EdgeInsets.all(_padding(context)),
              child: const Text("🫶🏾", style: TextStyle(fontSize: 30)),
            );
  }

  Text _quoteBanner(ColorScheme colorScheme) {
    return Text(
                "$_quoteText\n- $_quoteAuthor",
                style: TextStyle(
                  color: colorScheme.onPrimary,
                ),
                softWrap: true,
              );
  }

  Future<void> _getQuote() async {
    const String apiUrl = "https://jacintodesign.github.io/quotes-api/data/quotes.json";
    var response = await _dio.get(apiUrl);
    var quoteData = response.data;
    var quote = quoteData[_random.nextInt(quoteData.length)];
    setState(() {
      _quoteText = quote["text"];
      _quoteAuthor = quote["author"];
    });
  }
   
  double _padding(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.width * 0.05;
    } else {
      return MediaQuery.of(context).size.width * 0.03;
    }
  }
}

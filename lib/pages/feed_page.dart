import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late double _deviceHeight, _deviceWidth;

  String _quoteText = "Tap the bulb to get inspired";
  String _quoteAuthor = "Grateful Team";

  final Dio _dio = Dio();
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(_padding(context)),
                child: const Placeholder(),
              ),
              Padding(
                padding: EdgeInsets.all(_padding(context)),
                child: const Text("🫶🏾", style: TextStyle(fontSize: 30)),
              ),
              Padding(
                padding: EdgeInsets.all(_padding(context)),
                child: const Placeholder(),
              ),
              Padding(
                padding: EdgeInsets.all(_padding(context)),
                child: _quoteBanner(colorScheme),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: _padding(context)),
                child: IconButton(
                  iconSize: (_deviceWidth * .10),
                  tooltip: "Tap the lightbulb to get inspired.",
                  onPressed:() async {
                    await _getQuote();
                  }, 
                  icon: Icon(
                    Icons.lightbulb, 
                    color: colorScheme.onPrimaryContainer,
                    semanticLabel: "Tap the lightbulb to get inspired.",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Text _quoteBanner(ColorScheme colorScheme) {
    return Text(
                "$_quoteText\n- $_quoteAuthor",
                style: TextStyle(
                  color: colorScheme.onPrimaryContainer,
                ),
                softWrap: true,
              );
  }

  Future<void> _getQuote() async {
    const String _apiUrl = "https://jacintodesign.github.io/quotes-api/data/quotes.json";
    var _response = await _dio.get(_apiUrl);
    var _quoteData = _response.data;
    var _quote = _quoteData[_random.nextInt(_quoteData.length)];
    setState(() {
      _quoteText = _quote["text"];
      _quoteAuthor = _quote["author"];
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

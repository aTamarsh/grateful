import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late double _deviceHeight, _deviceWidth;

  String _quoteText = "Tap below to get inspired";
  bool _displaying = false;

  final Dio _dio = Dio();

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(_padding(context)),
                child: const Placeholder(),
              ),
              Padding(
                padding: EdgeInsets.all(_padding(context)),
                child: Text("🫶🏾", style: TextStyle(fontSize: 30)),
              ),
              Padding(
                padding: EdgeInsets.all(_padding(context)),
                child: const Placeholder(),
              ),
              Padding(
                padding: EdgeInsets.all(_padding(context)),
                child: Text(
                  _quoteText,
                  style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: _padding(context)),
                child: IconButton(
                  onPressed:() async {
                    const String _apiUrl = "https://jacintodesign.github.io/quotes-api/data/quotes.json";
                    var _response = await _dio.get(_apiUrl);
                    print("button pressed");
                    print(_response);
                  }, 
                  icon: Icon(
                    Icons.lightbulb, 
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  // Future<String> _getQuote() async {
  //   const String apiUrl = "https://jacintodesign.github.io/quotes-api/data/quotes.json";
  //   try {
  //     var _response = await _dio.get(apiUrl);
  //     var _quotes = jsonDecode(_response.toString());
  //     var _quote = _response[1]["text"];
  //   } catch (e) {
  //     print("An exception occurred."); 
  //     return "Inspirational Quote load failed.";
  //   } 
  // }
  
  double _padding(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.width * 0.05;
    } else {
      return MediaQuery.of(context).size.width * 0.03;
    }
  }
}

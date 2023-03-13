import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grateful/widgets/expanded_tile.dart';

const String gratitudeInfoTitle = "🫶🏾 Practicing Gratitude is Good";
const String gratitudeInfoAuthor = "Mayo Clinic";
const String gratitudeInfoContent = "Expressing gratitude is associated with a host of mental and physical benefits. Studies have shown that feeling thankful can improve sleep, mood, and immunity. Gratitude can decrease depression, anxiety, difficulties with chronic pain, and risk of disease.";

const String writingInfoTitle = "✍🏿 Writing Everyday is Great";
const String writingInfoAuthor = "Mayo Clinic";
const String writingInfoContent = "Gratitude journaling is a fantastic way to develop a regular practice of appreciating things you are grateful for, and as the old saying goes, practice makes perfect. The act of writing something helps to retrain our brain towards that of thankfulness more than just creating a mental gratitude list.  Specifically, when we use multiple avenues such as thinking, writing and sharing, we have the advantage of increasing the speed at which we train our brain towards appreciation.";

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
      backgroundColor: colorScheme.primaryContainer,
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(_padding(context)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const ExpandedTile(
                  title: gratitudeInfoTitle, 
                  author: gratitudeInfoAuthor,
                  content: gratitudeInfoContent, 
                ),  
                Padding(
                  padding: EdgeInsets.all(_padding(context)),
                  child: Image.asset(
                    "assets/images/grateful_cat.png",
                    height: _deviceWidth * 0.25,
                  ),
                ),
                const ExpandedTile(
                  title: writingInfoTitle, 
                  author: writingInfoAuthor,
                  content: writingInfoContent, 
                ),
                _paddedEmoji(context, "💬"),
                _paddedQuoteBanner(context, colorScheme),
                _paddedAuthorBanner(context, colorScheme),
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
                      color: colorScheme.primary,
                      semanticLabel: "Tap the lightbulb to get inspired.",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Padding _paddedEmoji(BuildContext context, String emoji) {
    return Padding(
      padding: EdgeInsets.all(_padding(context)),
      child: Text(
        emoji, 
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.08
        ),
      ),
    );
  }

  Padding _paddedQuoteBanner(BuildContext context, ColorScheme colorScheme) {
    return Padding(
                padding: EdgeInsets.all(_padding(context)),
                child: _quoteBanner(context, colorScheme),
              );
  }

  Text _quoteBanner(BuildContext context, ColorScheme colorScheme) {
    double deviceWidth = MediaQuery.of(context).size.width; 
    if (_quoteText.length > 80) {
      return Text(
        _quoteText, 
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontFamily: "LibreBakserville",
          fontSize: deviceWidth * 0.04,
          color: colorScheme.primary
        )
      );
    } else {
      return Text(
                _quoteText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "LibreBaskerville",
                  color: colorScheme.primary,
                  fontSize: deviceWidth * 0.07,
                ),
                softWrap: true,
      );
    }
  }

  Padding _paddedAuthorBanner(BuildContext context, ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.all(_padding(context)),
      child: _authorBanner(colorScheme),
    );
  }

  Text _authorBanner(ColorScheme colorScheme) {
    return Text(
      _quoteAuthor,
      style: TextStyle(
        color: colorScheme.primary,
        fontSize: 20,
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

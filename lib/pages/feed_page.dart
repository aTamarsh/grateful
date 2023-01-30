import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05, vertical: _deviceHeight * 0.02),
      height: _deviceHeight,
      width: _deviceWidth,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Placeholder(),
            const Text("🫶🏿", style: TextStyle(fontSize: 30)),
            const Placeholder(),
            SizedBox(height: _deviceHeight * 0.03),
            const Text("Placeholder text for Quote Text"),
            IconButton(
              onPressed:() => print("button pressed"), 
              icon: const Icon(Icons.lightbulb)
            )
          ],
        ),
      ),
    );
  }
}
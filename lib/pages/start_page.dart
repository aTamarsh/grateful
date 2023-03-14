import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _appTitleWidget(colorScheme),
                Image.asset(
                  "assets/images/grateful_cat.png", 
                  height: _deviceHeight * 0.25,
                  width: _deviceWidth * 0.25,
                ),
                Text(
                  "The more grateful I am,\nthe more beauty I see.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _deviceWidth * 0.05,
                    color: colorScheme.primary,
                    fontFamily: "LibreBaskerville"
                  )
                ),
                MaterialButton(
                  onPressed: _startApp,
                  minWidth: _deviceWidth * 0.70,
                  height: _deviceHeight * 0.06,
                  color: colorScheme.primary,
                  child: Text(
                    "Start",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: _deviceWidth * 0.05,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Text(
                  "from\nTamarsh Abeysekera", 
                  style: TextStyle(
                    color: colorScheme.primary
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startApp() async => Navigator.popAndPushNamed(context, 'home');

  Text _appTitleWidget(ColorScheme colorScheme) {
    return Text(
                "Grateful",
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: _deviceHeight! * 0.05,
                  letterSpacing: 2,
                  fontFamily: "LibreBaskerville"
                )
              );
  }
}

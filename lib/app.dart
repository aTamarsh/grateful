import 'package:flutter/material.dart';
import 'package:grateful/color_schemes.g.dart';
import 'package:grateful/pages/home_page.dart';
import 'package:grateful/pages/start_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Grateful Project',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
        fontFamily: 'ProximaNova',
      ),
      initialRoute: 'start',
      routes: {
        'start':(context) => const StartPage(),
        'home':(context) => const HomePage()
      }
    );
  }
}

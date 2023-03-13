import 'package:flutter/material.dart';
import 'package:grateful/color_schemes.g.dart';
import 'package:grateful/pages/home_page.dart';

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
        canvasColor: lightColorScheme.primary,
        appBarTheme: AppBarTheme(
          backgroundColor: lightColorScheme.primary,
        )
      ),

      home: const HomePage(),
    );
  }
}

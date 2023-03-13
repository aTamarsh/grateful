import 'package:flutter/material.dart';
import 'package:grateful/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Grateful Project',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'ProximaNova'
      ),
      home: const HomePage(),
    );
  }
}

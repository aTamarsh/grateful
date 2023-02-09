import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:grateful/pages/home_page.dart';

void main() async {
  await Hive.initFlutter("hive_boxes");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Grateful Project',
      theme: ThemeData(
        useMaterial3: true,
        // primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

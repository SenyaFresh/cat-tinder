import 'package:flutter/material.dart';

import 'cat_screen.dart';

void main() {
  runApp(CatApp());
}

class CatApp extends StatelessWidget {

  const CatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cat Tinder',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xfffad8e1)),
        scaffoldBackgroundColor: Color(0xfffae0d8),
      ),
      home: CatScreen(),
    );
  }
}
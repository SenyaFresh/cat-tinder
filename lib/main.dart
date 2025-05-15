import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/presentation/blocs/cat_bloc.dart';
import 'package:project/service_locator.dart';
import 'presentation/screens/cat_screen.dart';

void main() {
  setupServiceLocator();
  runApp(const CatApp());
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
      home: BlocProvider<CatBloc>(
        create: (_) => sl<CatBloc>(),
        child: CatScreen(),
      ),
    );
  }
}
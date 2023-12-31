import 'package:flutter/material.dart';
import 'package:puzzle/PuzzlePage.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PuzzlePage(),
      theme: ThemeData(primaryColor: mainColor, primarySwatch: asd),
    );
  }
}

Color mainColor = Color(0xff5440F0);
MaterialColor asd = MaterialColor(
  0xff5440F0,
  <int, Color>{
    50: Color(0xFFFFEBEE),
    100: Color(0xFFFFCDD2),
    200: Color(0xFFEF9A9A),
    300: Color(0xFFE57373),
    400: Color(0xFFEF5350),
    500: Color(0xff5440F0),
    600: Color(0xFFE53935),
    700: Color(0xFFD32F2F),
    800: Color(0xFFC62828),
    900: Color(0xFFB71C1C),
  },
);
Color s = Colors.red;

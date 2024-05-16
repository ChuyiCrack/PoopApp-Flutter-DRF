import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.dark() ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.dark(
          secondary: Color.fromARGB(255, 28, 218, 192)
        )
        
      ),
      home: const loginStatefull(),
      );
}

}
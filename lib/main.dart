import 'package:flutter/material.dart';
import 'package:job_finder_flutter/themes/theme_provider.dart';
import 'package:job_finder_flutter/views/menu/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeProvider.light,
      home: const Menu(),
    );
  }
}

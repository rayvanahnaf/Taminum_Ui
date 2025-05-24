import 'package:flutter/material.dart';
import 'package:flutter_pos/providers/theme_providers.dart';
import 'package:provider/provider.dart';
import 'presentation/auth/pages/login_page.dart';
import 'presentation/pos/pages/pos_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter POS',
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(backgroundColor: Colors.orange),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111315),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      home: const PosPage(),
    );
  }
}
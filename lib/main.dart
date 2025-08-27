import 'package:flutter/material.dart';
import 'page/splash_screen.dart';  // Asumsi ini ada
import 'page/peta_pohon/map_page.dart';
import 'page/peta_pohon/add_data_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),  // Halaman splash awal
      routes: {
        '/map': (context) => const MapPage(),
        '/addData': (context) => AddDataPage(),
      },
    );
  }
}
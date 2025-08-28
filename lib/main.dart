
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'page/splash_screen.dart';
import 'page/peta_pohon/map_page.dart';
import 'page/peta_pohon/add_data_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
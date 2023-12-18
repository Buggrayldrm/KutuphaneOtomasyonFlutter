import 'package:flutter/material.dart';
import 'package:kutuphane_otomasyon/firebase_options.dart';
import 'package:kutuphane_otomasyon/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buğra Yıldırım 02210201002',
      home: HomePage(),
    );
  }
}

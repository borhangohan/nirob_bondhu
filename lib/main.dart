import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NirobBondhuApp());
}

class NirobBondhuApp extends StatelessWidget {
  const NirobBondhuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nirob Bondhu',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:test/firebase_options.dart';
import 'presentation/pages/calculator_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.subscribeToTopic("Time");
  await FirebaseMessaging.instance.subscribeToTopic("Total_Caculattion");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 0, 0),
          primary: const Color.fromARGB(255, 255, 255, 255),
          primaryContainer: const Color.fromARGB(255, 1, 1, 1),
          inversePrimary: const Color.fromARGB(255, 0, 0, 0),
        ),
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

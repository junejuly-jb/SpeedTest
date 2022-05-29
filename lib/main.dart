import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedtest/screens/home.dart';
import 'package:speedtest/screens/result_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/':(context) => const Home(),
        '/results':(context) => const ResultScreen(),
      },
    );
  }
}

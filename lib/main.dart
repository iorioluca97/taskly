import 'package:flutter/material.dart';

import 'Home_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Taskly",
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage());
  }
}

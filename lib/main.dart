import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwik/view/pages/FirstPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const kwikApp());
}

class kwikApp extends StatelessWidget {
  const kwikApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: FirstPage());
  }
}

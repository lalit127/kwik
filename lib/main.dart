import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwik/provider/auth_provider.dart';
import 'package:kwik/view/location_screen.dart';
import 'package:kwik/view/screens/current_location.dart';
import 'package:kwik/view/screens/homeScreen.dart';
import 'package:kwik/view/screens/search_screen/search_places.dart';
import 'package:kwik/view/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'view/onboardScreen/onboardingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(kwikApp());
}

class kwikApp extends StatelessWidget {
  const kwikApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          home: HomeScreen()),
    );
  }
}

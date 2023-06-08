import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kwik/view/screens/map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Expanded(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey.shade400,
          body: MapScreen(),
          
        ),
      ),
    );
  }
}

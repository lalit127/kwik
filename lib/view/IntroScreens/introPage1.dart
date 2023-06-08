import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 50, 0, 0),
              child: Container(
                height: 370,
                child: Image.asset('lib/assets/Images/firstIntro.png'),
              ),
            ),
            Row(
              children: [
                Text(
                  'Ride made',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Easy with Kwik',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      color: Color.fromARGB(255, 255, 108, 95),
    );
  }
}

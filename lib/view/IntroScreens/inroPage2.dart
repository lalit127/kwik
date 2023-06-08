import 'package:flutter/material.dart';
import 'package:kwik/utils/customButton.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
                child: Container(
                  height: 370,
                  child: Image.asset('lib/assets/Images/secondIntro.png'),
                ),
              ),
              Row(
                children: [
                  Text(
                    'No hassle,',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'quick with kwik',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        color: Colors.deepPurple.shade400);
  }
}

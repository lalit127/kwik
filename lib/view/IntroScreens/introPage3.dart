import 'package:flutter/material.dart';
import 'package:kwik/utils/customButton.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
                  child: Image.asset('lib/assets/Images/thirdIntro.png'),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Best Fare',
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
                      'Price with Kwik',
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
        color: Colors.amber);
  }
}

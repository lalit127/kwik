import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwik/view/pages/setupPage.dart';

import '../../utils/customButton.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 160, 0, 0),
              child: Text(
                'Get Started,',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 12, 5, 8),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                AnimatedTextKit(
                  totalRepeatCount: 1000,
                  animatedTexts: [
                    FadeAnimatedText(
                      'Instagram',
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.pinkAccent),
                    ),
                    FadeAnimatedText('Youtube',
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.red)),
                    FadeAnimatedText('Twitter',
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.blue)),
                    FadeAnimatedText('Spotify',
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.green)),
                  ],
                ),
              ],
            ),
            Text(
              'Manage Networks.',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 180, 0, 0),
              child: CustomButton(
                onPressed: () {
                  Get.to(SetupPage());
                },
                text: 'Add Links',
                textColor: Colors.black,
                buttonColor: Colors.greenAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}

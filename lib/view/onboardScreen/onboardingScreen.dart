import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwik/provider/auth_provider.dart';
import 'package:kwik/view/AuthScreen/authScreen.dart';
import 'package:kwik/view/IntroScreens/inroPage2.dart';
import 'package:kwik/view/IntroScreens/introPage1.dart';
import 'package:kwik/view/IntroScreens/introPage3.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/customButton.dart';
import '../screens/homeScreen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  //Controller to keep track of which page we're on

  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    // final ap = Provider.of<AuthProvider>(context, listen: false);
    // context.watch();
    return Scaffold(
      //pageview
      body: Stack(children: [
        PageView(
          controller: _controller,
          children: [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),

        // dot indicators

        Container(
          alignment: Alignment(-0.75, 0.75),
          child: SmoothPageIndicator(
            effect: WormEffect(
              dotColor: Colors.white,
              radius: 3.0,
              dotHeight: 10,
            ),
            controller: _controller,
            count: 3,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(220, 120, 20, 80),
              child: Consumer<AuthProvider>(builder: (context, value, child) {
                return CustomButton(
                    onPressed: () async {
                      if (Provider.of<AuthProvider>(context, listen: false)
                              .isSignedIn ==
                          true) {
                        await Provider.of<AuthProvider>(context, listen: false)
                            .getDataFromSP()
                            .whenComplete(() => Get.to(HomeScreen()));
                      } else {
                        Get.to(AuthScreen());
                      }
                      ;
                      // if (ap.isSignedIn == true) {
                      //   await ap.getDataFromSP().whenComplete(() {
                      //     Get.to(HomeScreen());
                      //   });
                      // } else {
                      //   Get.to(AuthScreen());
                      // }
                    },
                    text: 'Skip',
                    textColor: Colors.black,
                    buttonColor: Colors.white);
              }),
            ),
          ],
        )
      ]),
    );
  }
}

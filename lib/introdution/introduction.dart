import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Introductioncreen extends StatelessWidget {
  const Introductioncreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration =  PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
          globalBackgroundColor: Colors.white,
          allowImplicitScrolling: true,
        autoScrollDuration: 3000,
        pages: [
          PageViewModel(
            title: 'Run Your Code',
            body: 'Run and compile your MIPS assembly code on M.A.Roid with interactive and easy to use interface.',
            image: Container(
              margin: const EdgeInsets.only(top: 100),
                child: Image.asset('assets/first.gif')),
            decoration: pageDecoration
          ),
          PageViewModel(
              title: 'See Output',
              body: 'Displaying output step by step comprehensively.',
              image: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Image.asset('assets/second.gif')),
              decoration: pageDecoration
          ),
          PageViewModel(
              title: 'Easy to Use',
              body: 'M.A.Roid comes with convenient graphics and interface for its users',
              image: Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: Image.asset('assets/third.gif')),
              decoration: pageDecoration
          ),
        ],
      onDone: () => Navigator.pushNamed(context, '/mainMenu'),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

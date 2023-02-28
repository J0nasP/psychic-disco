import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Shader linearGradient = const LinearGradient(colors: <Color>[
  Color.fromRGBO(255, 79, 64, 100),
  Color.fromRGBO(255, 68, 221, 100)
], begin: Alignment.topLeft, end: Alignment.topRight)
    .createShader(const Rect.fromLTWH(0.0, 0.0, 500.0, 70.0));

class HeroWidget extends StatelessWidget {
  const HeroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child:
            Image.asset('assets/images/png/logo-no-background.png', width: 24),
      ),
      Expanded(
          child: Container(
              margin: const EdgeInsets.all(24.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Flutter',
                        style: GoogleFonts.spaceGrotesk(
                          foreground: Paint()..shader = linearGradient,
                          fontSize: 80,
                          height: 0.8,
                          fontWeight: FontWeight.w800,
                        )),
                    Text('Sample App',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 80,
                          height: 0.8,
                          fontWeight: FontWeight.w600,
                        )),
                  ])))
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PAMLogo extends StatelessWidget {
  const PAMLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.contain,
            width: 80,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kaos Nyaman",
              style: GoogleFonts.lemon(
                  fontSize: 20,
                  color: const Color(0xff56D5A8)
              ),
            ),
            Text(
              "Online clothes shop",
              style: GoogleFonts.lato(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor
              ),
            )
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class BrokenWidget extends StatelessWidget {
  const BrokenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.public_off,
          size: 30,
        ),
        Text(
          "something wrong."
        )
      ],
    );
  }
}
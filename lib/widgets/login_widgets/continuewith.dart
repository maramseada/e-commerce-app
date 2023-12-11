import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContinueScreen extends StatelessWidget {
  const ContinueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust as needed
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xFF296C99),
            ),
            width: 50,
            height: 50,
            child: const Align(
              alignment: Alignment.center,
              child: FaIcon(
                FontAwesomeIcons.facebookF,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0x8A9F2424),
            ),
            width: 50,
            height: 50,
            child: const Align(
              alignment: Alignment.center,
              child: FaIcon(
                FontAwesomeIcons.google,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black45,
            ),
            width: 50,
            height: 50,
            child: const Icon(
              Icons.apple_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

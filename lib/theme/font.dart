import 'package:flutter/material.dart';

import 'colors.dart';

const kSmallFontOfGrey = TextStyle(
    color: const Color.fromARGB(138, 0, 0, 0),
    fontFamily: "Roboto",
    fontSize: 12,
    height: 1.33333,
    decoration: TextDecoration.none);

const kSmallFontOfGreen = TextStyle(
  color: const Color.fromARGB(255, 16, 196, 105),
  fontFamily: "Roboto",
  fontSize: 12,
  height: 1.33333,
);

const kSmallFontOfRed = TextStyle(
  color: Color.fromARGB(255, 255, 91, 91),
  fontFamily: "Roboto",
  fontSize: 12,
  height: 1.33333,
);

const kMiddleFontOfGrey = TextStyle(
  color: const Color.fromARGB(138, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 14,
  height: 1.33333,
);

const kMiddleFontOfGreyLink = TextStyle(
  color: const Color.fromARGB(138, 0, 0, 0),
  decoration: TextDecoration.underline,
  fontFamily: "Roboto",
  fontSize: 14,
);

const kMiddleFontOfBlue = TextStyle(
  color: Colors.blue,
  fontFamily: "Roboto",
  fontSize: 14,
);

const kMiddleFontOfBlueLink = TextStyle(
  color: const Color.fromARGB(255, 27, 20, 120),
  decoration: TextDecoration.underline,
  fontFamily: "Roboto",
  fontSize: 14,
);

const kMiddleFontOfGreen = TextStyle(
  color: const Color.fromARGB(255, 16, 196, 105),
  fontFamily: "Roboto",
  fontSize: 14,
  height: 1.33333,
);

const kMiddleFontOfRed = TextStyle(
  color: Colors.red,
  fontFamily: "Roboto",
  fontSize: 14,
  height: 1.33333,
);

const kMiddleFontOfBlack = TextStyle(
  color: const Color.fromARGB(222, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 15,
  height: 1.5,
);

const kMiddleFontOfWhite = TextStyle(
  color: const Color.fromARGB(255, 255, 255, 255),
  fontFamily: "Roboto",
  fontSize: 15,
  height: 1.5,
);

const kBigFontOfBlack = TextStyle(
  color: const Color.fromARGB(222, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 16,
  height: 1.5,
);

const kVeryBigFontOfBlack = TextStyle(
  color: const Color.fromARGB(222, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 24,
);

const kBigFontOfBlue = TextStyle(
  color: const Color.fromARGB(255, 77, 137, 229),
  fontFamily: "Roboto",
  fontSize: 16,
  height: 1.5,
);

const kBigFontOfDartBlue = TextStyle(
  color: const Color.fromARGB(255, 28, 20, 120),
  fontFamily: "Roboto",
  fontSize: 16,
  height: 1.5,
);

const kBigFontOfGrey = TextStyle(
  color: const Color.fromARGB(138, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 16,
  height: 1.5,
);

const kSecondaryButtonOfPurple = TextStyle(
  color: buttonPrimaryColor,
  fontFamily: "Roboto",
  fontSize: 14,
);

const kSecondaryButtonOfBlack = TextStyle(
  color: const Color.fromARGB(222, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 14,
);

const kSecondaryButtonOfWhite = TextStyle(
  color: Colors.white,
  fontFamily: "Roboto",
  fontSize: 14,
);

const kRowShodow = BoxDecoration(
  color: panelColor,
  borderRadius: BorderRadius.all(Radius.circular(12)),
  boxShadow: [
    BoxShadow(
      color: shodowColor,
      offset: Offset(0, 2),
      blurRadius: 7,
    ),
  ],
);

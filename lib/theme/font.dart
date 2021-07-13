import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'colors.dart';

class MiddleFontOfColor extends TextStyle {
  final Color color;

  MiddleFontOfColor({this.color = const Color.fromARGB(222, 0, 0, 0)}) {
    TextStyle(
      color: color,
      fontFamily: "Roboto",
      fontSize: 15,
      height: 1.5,
    );
  }
}

@deprecated
const kSmallFontOfGreen = TextStyle(
  color: const Color.fromARGB(255, 16, 196, 105),
  fontFamily: "Roboto",
  fontSize: 12,
  height: 1.33333,
);

@deprecated
const kSmallFontOfRed = TextStyle(
  color: Color.fromARGB(255, 255, 91, 91),
  fontFamily: "Roboto",
  fontSize: 12,
  height: 1.33333,
);

@deprecated
const kMiddleFontOfGreen = TextStyle(
  color: const Color.fromARGB(255, 16, 196, 105),
  fontFamily: "Roboto",
  fontSize: 14,
  height: 1.33333,
);

// const FontTheme.of(context).big.label() = TextStyle(
//   color: whiteColor,
//   fontFamily: "Roboto",
//   fontSize: 16,
//   height: 1.5,
// );

// const FontTheme.of(context).big.mxc() = TextStyle(
//   color: const Color.fromARGB(255, 28, 20, 120),
//   fontFamily: "Roboto",
//   fontSize: 16,
//   height: 1.5,
// );

// const FontTheme.of(context).big.secondary() = TextStyle(
//   color: const Color.fromARGB(138, 0, 0, 0),
//   fontFamily: "Roboto",
//   fontSize: 16,
//   height: 1.5,
// );

// final kSecondaryButtonOfPurple = TextStyle(
//   color: mxcBlue,
//   fontFamily: "Roboto",
//   fontSize: 14,
// );

// const kSecondaryButtonOfBlack = TextStyle(
//   color: const Color.fromARGB(222, 0, 0, 0),
//   fontFamily: "Roboto",
//   fontSize: 14,
// );

// const kSecondaryButtonOfWhite = TextStyle(
//   color: whiteColor,
//   fontFamily: "Roboto",
//   fontSize: 14,
// );

const kSecondaryButtonOfGrey = TextStyle(
  color: greyColor,
  fontFamily: "Roboto",
  fontSize: 14,
);

BoxDecoration rowShadow(BuildContext context) => BoxDecoration(
      color: ColorsTheme.of(context).secondaryBackground,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          color: shodowColor,
          offset: Offset(0, 2),
          blurRadius: 7,
        ),
      ],
    );

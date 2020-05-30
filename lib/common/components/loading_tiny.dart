import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loading({BuildContext context, bool isSmall = false}) {
  return isSmall
      ? indicatior(context)
      : Scaffold(
          backgroundColor: Colors.transparent, body: indicatior(context));
}

Widget indicatior(BuildContext context) {
  return Center(
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: SpinKitPulse(
          color: Color.fromARGB(255, 28, 20, 120),
          size: 50.0,
        ),
      ),
    ),
  );
}

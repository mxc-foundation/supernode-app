import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

Widget homeBar(String title,{Function onPressed}){
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: 0,
    title: Text(
      title,
      textAlign: TextAlign.left,
      style: kBigFontOfBlack,
    ),
    actions: [
      onPressed != null ? IconButton(
        icon: Icon(
          Icons.settings,
          color: Colors.black,
        ),
        onPressed: onPressed,
      ) :
      Container()
    ],
  );
}
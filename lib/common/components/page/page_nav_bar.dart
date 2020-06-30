import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget pageNavBar(String name,{EdgeInsetsGeometry padding,Function onTap,bool hideClose=false}){
  return Container(
    padding: padding,
    child: Row(
      children: <Widget>[
        Text(
          name,
          textAlign: TextAlign.left,
          style: kBigFontOfBlack,
        ),
        Spacer(),
        hideClose ? SizedBox()
        : GestureDetector(
          child: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onTap: onTap,
        ),
      ],
    )
  );
}
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget pageNavBar(String name,
    {EdgeInsetsGeometry padding, Function onTap, Widget actionWidget}) {
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
          GestureDetector(
            child: actionWidget == null
                ? Icon(
                    Icons.close,
                    color: Colors.black,
                  )
                : actionWidget,
            onTap: onTap,
          ),
        ],
      ));
}

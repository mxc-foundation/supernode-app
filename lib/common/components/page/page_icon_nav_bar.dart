import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget pageIconNavBar(
    {Widget title,
    EdgeInsetsGeometry padding,
    Function onTap,
    Widget leading}) {
  return Container(
      padding: padding,
      child: Row(
        children: <Widget>[
          leading ?? Container(),
          Expanded(
            child: title ?? Container(),
          ),
          GestureDetector(
            child: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onTap: onTap,
          ),
        ],
      ));
}

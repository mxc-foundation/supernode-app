import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget profile({String name = '',String position = '',EdgeInsetsGeometry contentPadding,Widget trailing,Function onTap}){
  return ListTile(
    contentPadding: contentPadding,
    leading: Icon(
      Icons.account_circle,
      size: 44,
    ),
    title: Text(
      name,
      style: kBigFontOfBlack,
    ),
    subtitle: Text(
      position,
      style: kMiddleFontOfGrey,
    ),
    trailing: trailing,
    onTap: onTap,
  );
}
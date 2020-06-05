import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

Widget panelBody(
    {String titleText,
    String subtitleText,
    String trailTitle,
    trailSubtitle,
    IconData icon,
    Function onPressed}) {
  var temp = trailSubtitle.split('(');
  String mxcPrice = temp[0].substring(0, temp[0].length - 1);
  String usdPrice = temp[1].substring(0, temp[1].length - 1);

  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            icon,
            color: buttonPrimaryColor,
            size: 50,
          ),
          onPressed: onPressed,
        )),
    title: Text(
      titleText,
      textAlign: TextAlign.left,
      style: kMiddleFontOfBlack,
    ),
    subtitle: Text(
      subtitleText,
      textAlign: TextAlign.left,
      style: kBigFontOfBlack,
    ),
    trailing: Container(
      margin: EdgeInsets.only(top: 10, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(trailTitle, style: kSmallFontOfGrey),
          Text(
            mxcPrice,
            style: kMiddleFontOfBlack,
          )
        ],
      ),
    ),
  );
}

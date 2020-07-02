import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class FootPrintsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,2),
              blurRadius: 7,
              color: boxShadowColor,
            )
          ]
        ),
        child: ListTile(
          title: Text(
            '2020-05-20 09:39:12 14km -135dBm',
            style: kMiddleFontOfGrey,
          ),
          trailing: Icon(
            Icons.location_on,
            size: 22,
            color: dbm120,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

class LineColor extends StatelessWidget {
  final String firstText;
  final Color firstColor;
  final String secondText;
  final Color secondColor;
  final String thirdText;
  final Color thirdColor;

  const LineColor(
      {Key key,
      this.firstText,
      this.firstColor,
      this.secondText,
      this.secondColor,
      this.thirdText,
      this.thirdColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 17),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
                color: firstColor,
              ),
              child: Text(
                firstText ?? "",
                textAlign: TextAlign.center,
                style: kSmallFontOfWhite,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: secondColor,
              child: Text(
                secondText ?? "",
                textAlign: TextAlign.center,
                style: kSmallFontOfWhite,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                color: thirdColor,
              ),
              child: Text(
                thirdText ?? "",
                textAlign: TextAlign.center,
                style: kSmallFontOfWhite,
              ),
            ),
          )
        ],
      ),
    );
  }
}

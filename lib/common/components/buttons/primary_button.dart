import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key key,
    @required this.onTap,
    @required this.buttonTitle,
    this.minHeight = 36,
    this.minWidth = 0,
    this.bgColor = buttonPrimaryColor,
    this.textColor = whiteColor,
    this.padding = const EdgeInsets.symmetric(vertical: 0),
    this.borderRadius = const BorderRadius.all(Radius.circular(3)),
    TextStyle textStyle,
  })  : this.style = textStyle ??
            TextStyle(
              color: textColor,
              fontFamily: "Roboto",
              fontSize: 15,
              height: 1.5,
            ),
        super(key: key);

  final Color bgColor;
  final Color textColor;
  final String buttonTitle;
  final Function onTap;
  final double minHeight;
  final double minWidth;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight, minWidth: minWidth),
        child: RaisedButton(
          onPressed: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
          color: bgColor,
          child: Text(
            buttonTitle,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
      ),
    );
  }
}

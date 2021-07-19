import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key key,
    @required this.onTap,
    @required this.buttonTitle,
    this.minHeight = 36,
    this.minWidth = 0,
    this.bgColor,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(vertical: 0),
    this.borderRadius = const BorderRadius.all(Radius.circular(3)),
    this.style,
  }) : super(key: key);

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
          color: bgColor ?? ColorsTheme.of(context).mxcBlue,
          child: Text(
            buttonTitle,
            textAlign: TextAlign.center,
            style: style ??
                TextStyle(
                  color:
                      textColor ?? ColorsTheme.of(context).buttonIconTextColor,
                  fontFamily: "Roboto",
                  fontSize: 15,
                  height: 1.5,
                ),
          ),
        ),
      ),
    );
  }
}

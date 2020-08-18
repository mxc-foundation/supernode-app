import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    @required this.onTap,
    @required this.buttonTitle,
    this.minHeight = 36,
    this.minWidget = 0,
    this.bgColor = buttonPrimaryColor,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 0),
    Key key,
  }) : super(key: key);

  final Color bgColor;
  final Color textColor;
  final String buttonTitle;
  final Function onTap;
  final double minHeight;
  final double minWidget;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight, minWidth: minWidget),
      child: RaisedButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        color: bgColor,
        child: Container(
          child: Text(
            buttonTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
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

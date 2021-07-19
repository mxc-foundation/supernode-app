import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

Widget submitButton(
  String label, {
  double top = 34,
  Function onPressed,
  Key key,
  Color color,
  TextStyle textStyle,
}) {
  return Builder(
    builder: (context) {
      textStyle ??= onPressed == null
          ? FontTheme.of(context).middle.label()
          : FontTheme.of(context).middle.button();
      return Container(
        height: 45,
        width: double.infinity,
        margin: EdgeInsets.only(top: top),
        child: FlatButton(
          key: key,
          onPressed: onPressed,
          color: color ?? ColorsTheme.of(context).dhxBlue,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: color ?? ColorsTheme.of(context).dhxBlue,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          padding: EdgeInsets.all(0),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
      );
    },
  );
}

class WhiteBorderButton extends StatelessWidget {
  final String label;
  final double top;
  final Function onPressed;
  const WhiteBorderButton(
    this.label, {
    Key key,
    this.top = 34,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = (onPressed == null)
        ? darkThemeColors.textLabel
        : darkThemeColors.textPrimaryAndIcons;
    return Container(
      height: 45,
      margin: EdgeInsets.only(top: top),
      child: FlatButton(
        key: key,
        onPressed: onPressed,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: color,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        textColor: color,
        padding: EdgeInsets.all(0),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

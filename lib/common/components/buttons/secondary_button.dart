import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({
    @required this.onTap,
    @required this.buttonTitle,
    this.color,
    this.icon,
    this.isSelected = false,
    Key key,
  }) : super(key: key);

  final String buttonTitle;
  final Function onTap;
  final Color color;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      color: color,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: color != null ? color : ColorsTheme.of(context).mxcBlue,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      // color: buttonSecondaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            buttonTitle,
            textAlign: TextAlign.center,
            style: color != null && !isSelected
                ? FontTheme.of(context).middle.primary()
                : FontTheme.of(context).middle.mxc(),
          ),
          icon != null
              ? Container(
                  margin: kInnerRowLeft5,
                  child: Icon(
                    icon,
                    color: color != null && !isSelected
                        ? ColorsTheme.of(context).textPrimaryAndIcons
                        : ColorsTheme.of(context).mxcBlue,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

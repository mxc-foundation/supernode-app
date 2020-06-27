import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class SecondaryShadowButton extends StatelessWidget {
  SecondaryShadowButton(
      {@required this.onTap,
      @required this.buttonTitle,
      this.color,
      this.icon,
      this.isSelected = false});

  final String buttonTitle;
  final Function onTap;
  final Color color;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          boxShadow: [
            BoxShadow(
              color: shodowColor,
              offset: Offset(0, 2),
              blurRadius: 7,
            ),
          ]),
      child: InkWell(
        onTap: onTap,
        child: Row(children: <Widget>[
          Text(
            buttonTitle,
            textAlign: TextAlign.center,
            style: color != null && !isSelected
                ? kSecondaryButtonOfBlack
                : kSecondaryButtonOfPurple,
          ),
          icon != null
              ? Container(
                  margin: kInnerRowLeft5,
                  child: Icon(
                    icon,
                    size: 20,
                    color: color != null && !isSelected
                        ? Colors.black
                        : buttonPrimaryColor,
                  ),
                )
              : Container()
        ]),
      ),
    );
  }
}

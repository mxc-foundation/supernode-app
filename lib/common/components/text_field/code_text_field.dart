import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class CodeTextField extends StatelessWidget {
  CodeTextField({this.textInputAction = TextInputAction.next});

  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: boxShadowColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: boxShadowColor, width: 2),
          )),
      onSubmitted: (_) => textInputAction == TextInputAction.next
          ? FocusScope.of(context).nextFocus()
          : FocusScope.of(context).unfocus(),
      style: FontTheme.of(context).middle(),
      maxLines: 1,
      autocorrect: false,
      keyboardType: TextInputType.number,
      textInputAction: textInputAction,
    );
  }
}

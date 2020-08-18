import 'package:flutter/cupertino.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/colors.dart' as c;

class TextFieldWithTitle extends StatelessWidget {
  TextFieldWithTitle({
    @required this.title,
    this.hint,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.controller,
    this.suffixChild,
    this.suffixTitleChild,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.onChanged,
    this.maxLength,
    this.borderColor = c.borderColor,
    this.counterText,
    Key key,
  }) : super(key: key);

  final Color borderColor;
  final String title;
  final String hint;
  final bool isObscureText;
  final TextInputAction textInputAction;
  final Function(String) validator;
  final TextEditingController controller;
  final Widget suffixChild;
  final Widget suffixTitleChild;
  final bool readOnly;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final int maxLength;
  final String counterText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Visibility(
              visible: title.isNotEmpty,
              child: Text(
                title,
                style: kMiddleFontOfBlack,
              ),
            ),
            Spacer(),
            Visibility(
              visible: suffixTitleChild != null,
              child: suffixTitleChild ?? Container(),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          // height: 45,
          child: Stack(
            children: <Widget>[
              PrimaryTextField(
                  borderColor: borderColor,
                  maxLength: maxLength,
                  counterText: counterText,
                  readOnly: readOnly,
                  textAlign: textAlign,
                  keyboardType: keyboardType,
                  hint: hint,
                  isObscureText: isObscureText,
                  validator: validator,
                  controller: controller,
                  onChanged: onChanged),
              Positioned(
                  right: 0,
                  child: Visibility(
                      visible: suffixChild != null,
                      child: suffixChild ?? Container())),
            ],
          ),
        )
      ],
    );
  }
}

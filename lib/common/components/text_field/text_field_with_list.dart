import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class TextFieldWithList extends StatefulWidget {
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

  TextFieldWithList({
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
    this.counterText,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TextFieldWithTitleState();
  }
}

class TextFieldWithTitleState extends State<TextFieldWithList> {
  FocusNode _focusNode = FocusNode();

  OverlayEntry _overlayEntry;
  List<String> users =
      StorageManager.sharedPreferences.getStringList(Config.USER_KEY) ?? [];

  searchUser(search) {
    users =
        StorageManager.sharedPreferences.getStringList(Config.USER_KEY) ?? [];
    List<String> _users = [];
    for (var item in users) {
      if (item.contains(search)) {
        _users.add(item);
      }
    }
    users = _users;
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (_focusNode.hasFocus && widget.controller.text != '') {
        searchUser(widget.controller.text);
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);
      } else {
        try {
          if (this._overlayEntry != null) {
            this._overlayEntry.remove();
          }
        } catch (e) {
          print('pass');
        }
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    try {
      if (this._overlayEntry != null) {
        this._overlayEntry.remove();
      }
    } catch (e) {
      print('pass');
    }

    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) => Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 5.0,
              width: size.width,
              child: Material(
                  elevation: 4.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: users.length,
                    itemBuilder: (context, int index) {
                      return Container(
                        decoration: new BoxDecoration(
                            border:
                                new Border(bottom: new BorderSide(width: 0.1))),
                        child: ListTile(
                          dense: true,
                          onTap: () {
                            setState(() {
                              widget.controller.text =
                                  "${users.elementAt(index)}";

                              FocusScope.of(context).requestFocus(FocusNode());
                              try {
                                if (this._overlayEntry != null) {
                                  this._overlayEntry.remove();
                                }
                              } catch (e) {
                                print('pass');
                              }
                            });
                          },
                          title: Text("${users.elementAt(index)}",
                              style: new TextStyle(fontSize: 18.0)),
                        ),
                      );
                    },
                  )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Visibility(
              visible: widget.title.isNotEmpty,
              child: Text(
                widget.title,
                style: kMiddleFontOfBlack,
              ),
            ),
            Spacer(),
            Visibility(
              visible: widget.suffixTitleChild != null,
              child: widget.suffixTitleChild ?? Container(),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          // height: 45,
          child: Stack(
            children: <Widget>[
              TextFormField(
                focusNode: _focusNode,
                maxLength: widget.maxLength,
                textAlign: widget.textAlign,
                readOnly: widget.readOnly,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                  contentPadding: kRoundRow105,
                  hintText: widget.hint,
                  counterText: widget.counterText,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                ),
                onFieldSubmitted: (_) =>
                    widget.textInputAction == TextInputAction.next
                        ? FocusScope.of(context).nextFocus()
                        : FocusScope.of(context).unfocus(),
                style: kMiddleFontOfBlack,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 1,
                obscureText: widget.isObscureText,
                autocorrect: false,
                textInputAction: widget.textInputAction,
//                initialValue: initialValue,
                validator: widget.validator,
                controller: widget.controller,
                onChanged: widget.onChanged,
              ),
              Positioned(
                right: 0,
                child: Visibility(
                    visible: widget.suffixChild != null,
                    child: widget.suffixChild ?? Container()),
              )
            ],
          ),
        )
      ],
    );
  }
}

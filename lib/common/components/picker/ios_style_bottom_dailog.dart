import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

abstract class _IosStyleBottomDialogBase extends StatelessWidget {
  final OnItemClickListener onItemClickListener;
  final BuildContext context;

  const _IosStyleBottomDialogBase({
    Key key,
    this.onItemClickListener,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          left: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {},
            child: buildDialog(),
          ),
        ),
      ],
    );
  }

  Widget buildDialog();
}

class IosButtonStyle {
  String title;
  TextStyle style;

  IosButtonStyle({String title, TextStyle style = kBigFontOfBlack}) {
    this.title = title;
    this.style = style;
  }
}

typedef OnItemClickListener = void Function(int index);

///
/// iOS style Bottom Dialog with list of buttons IosButtonStyle
/// and a separate Cancel button by default
///
class IosStyleBottomDialog extends _IosStyleBottomDialogBase {
  final int blueActionIndex;
  final List<IosButtonStyle> list;

  const IosStyleBottomDialog({
    Key key,
    @required this.list,
    OnItemClickListener onItemClickListener,
    this.blueActionIndex = -1,
    BuildContext context,
  }) : super(key: key, onItemClickListener: onItemClickListener, context: context);

  @override
  Widget buildDialog(){
    return Column(
      children: <Widget>[
        _buildContentList(context),
        _buildCancelItem(context),
      ],
    );
  }

  Widget _buildContentList(BuildContext context) {
    List<Widget> listContent = [];

    if (blueActionIndex > -1 && blueActionIndex < list.length) {
      if (list.length == 1) {
        listContent
            .add(_buildSelectedItem(context, button: list[blueActionIndex]));
      } else {
        listContent
            .add(_buildSelectedItem(context, button: list[blueActionIndex]));
        listContent.add(Divider(color: borderColor, height: 1));
        int i = 0;
        for (; i < list.length - 1; i++) {
          if (blueActionIndex != i) {
            listContent.add(_buildItem(context, button: list[i], index: i));
            listContent.add(Divider(color: borderColor, height: 1));
          }
        }
        listContent.add(_buildItem(context, button: list[i], index: i));
      }
    } else {
      if (list.length == 1) {
        listContent.add(_buildItem(context, button: list[0], index: 0));
      } else {
        int i = 0;
        for (; i < list.length - 1; i++) {
          if (blueActionIndex != i) {
            listContent.add(_buildItem(context, button: list[i], index: i));
            listContent.add(Divider(color: borderColor, height: 1));
          }
        }
        listContent.add(_buildItem(
          context,
          button: list[i],
        ));
      }
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: shodowColor,
              offset: Offset(0, 2),
              blurRadius: 7,
            ),
          ]),
      child: Column(
        children: listContent,
      ),
    );
  }

  Widget _buildSelectedItem(context, {IosButtonStyle button}) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(button?.title ?? '', style: kBigFontOfBlue),
      ),
    );
  }

  Widget _buildItem(BuildContext context, {IosButtonStyle button, int index}) {
    return InkWell(
      onTap: () {
        onItemClickListener(index);
        Navigator.pop(context);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Text(button?.title ?? '', style: button.style),
      ),
    );
  }

  Widget _buildCancelItem(context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 43),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: shodowColor,
                offset: Offset(0, 2),
                blurRadius: 7,
              ),
            ]),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Text(FlutterI18n.translate(context, 'device_cancel'),
            style: kBigFontOfBlack),
      ),
    );
  }
}

///
/// iOS style Bottom Dialog with UI defined by param child
///
class IosStyleBottomDialog2 extends _IosStyleBottomDialogBase {
  final Widget child;

  const IosStyleBottomDialog2({
    Key key,
    @required this.child,
    OnItemClickListener onItemClickListener,
    BuildContext context,
  }) : super(key: key, onItemClickListener: onItemClickListener, context: context);

  @override
  Widget buildDialog(){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: shodowColor,
              offset: Offset(0, 2),
              blurRadius: 7,
            ),
          ]),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 22, right:22, top: 28, bottom:60),
      child: child,
    );
  }
}
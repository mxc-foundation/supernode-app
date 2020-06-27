import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/bottom_sheet/ios_style_bottom_sheet.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

const dartBlue = Color.fromRGBO(28, 20, 120, 1);

Widget buildView(
    ChooseApplicationState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  return Builder(
    builder: (context) {
      return Scaffold(
        body: pageBody(children: [
          Container(
            padding: EdgeInsets.only(top: kToolbarHeight, bottom: 10, left: 10),
            child: Text(
              FlutterI18n.translate(_ctx, 'device_choose'),
              style: kBigFontOfBlack,
            ),
          ),
          panelFrame(
            child: _buildPanelItem(
              icon: Icons.camera_enhance,
              title: FlutterI18n.translate(_ctx, 'ai_camera'),
              trailing: Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: Colors.black,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    var list = List();
                    list.add('AI Camera');
                    list.add('Fire Detect');
                    list.add('Waste Detect');
                    list.add('Human Detect');
                    return IosStyleBottomSheet(
                      list: list,
                      onItemClickListener: (index) async {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          ),
          panelFrame(
            child: _buildPanelItem(
              icon: Icons.vpn_key,
              title: FlutterI18n.translate(_ctx, 'smart_watch'),
            ),
          ),
          panelFrame(
            child: _buildPanelItem(
              icon: Icons.watch,
              title: FlutterI18n.translate(_ctx, 'smart_door_lock'),
              onTap: () {
                showDialog(
                  context: _ctx,
                  builder: (context) {
                    return _buildSmartDialog(_ctx);
                  },
                );
              },
            ),
          ),
          panelFrame(
            child: _buildPanelItem(
              icon: Icons.directions_car,
              title: FlutterI18n.translate(_ctx, 'smart_parking'),
            ),
          ),
          SizedBox(height: 30),
          _buildButton(
            onPressed: () {
              Navigator.pop(_ctx);
            },
            title: FlutterI18n.translate(_ctx, "update"),
          ),
          SizedBox(height: 20),
          _buildButton(
            onPressed: () {
              Navigator.pop(_ctx);
            },
            title: FlutterI18n.translate(_ctx, "device_cancel"),
          ),
        ]),
      );
    },
  );
}

Widget _buildButton({VoidCallback onPressed, String title}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: shodowColor,
            offset: Offset(0, 2),
            blurRadius: 7,
          ),
        ],
      ),
      child: Text(
        title ?? "",
        style: kBigFontOfDartBlue,
      ),
    ),
  );
}

Widget _buildSmartDialog(BuildContext ctx) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    title: Container(
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: dartBlue,
              shape: BoxShape.circle,
            ),
            width: 44,
            height: 44,
          ),
          Positioned(
            child: Icon(
              Icons.watch,
              size: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
    content: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            FlutterI18n.translate(ctx, "smart_watchID") + "(Bluetooth name)",
            style: kBigFontOfBlack,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 14),
          Text(
            FlutterI18n.translate(ctx, "smart_bluetooth_connect"),
            textAlign: TextAlign.center,
            style: kMiddleFontOfGrey,
          ),
          SizedBox(height: 38),
          Text(
            FlutterI18n.translate(ctx, 'goto_bluetooth_setting'),
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 14,
              color: dartBlue,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPanelItem(
    {IconData icon, String title, Widget trailing, VoidCallback onTap}) {
  return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      leading: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: dartBlue,
              shape: BoxShape.circle,
            ),
            width: 44,
            height: 44,
          ),
          Positioned(
            child: Icon(
              icon ?? Icons.not_interested,
              size: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
      title: Text(
        title ?? "",
        style: kBigFontOfBlack,
      ),
      trailing: trailing);
}

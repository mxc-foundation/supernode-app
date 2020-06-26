import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/bottom_sheet/ios_style_bottom_sheet.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/select_picker.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    ChooseApplicationState state, Dispatch dispatch, ViewService viewService) {
  var _ctx=viewService.context;
  return Scaffold(
    body: pageBody(children: [
      Container(
        padding: EdgeInsets.only(top: kToolbarHeight, bottom: 10, left: 10),
        child: Text(
          'Choose Your Application',
          style: kBigFontOfBlack,
        ),
      ),
      panelFrame(
        child: _buildPanelItem(
            icon: Icons.camera_enhance,
            title: 'AI Camera',
            trailing: Icon(
              Icons.keyboard_arrow_down,
              size: 30,
              color: Colors.black,
            ),
            onTap: () {
              showBottomSheet(
//                  barrierDismissible: true,
                  context: _ctx,
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
                  });
            }),
      ),
      panelFrame(
        child: _buildPanelItem(icon: Icons.vpn_key, title: 'Smart Watch'),
      ),
      panelFrame(
        child: _buildPanelItem(icon: Icons.watch, title: 'Smart Door Lock'),
      ),
      panelFrame(
        child:
            _buildPanelItem(icon: Icons.directions_car, title: 'Smart Parking'),
      ),
      SizedBox(height: 30),
      _buildButton(
        onPressed: () {
          Navigator.pop(_ctx);
        },
        title: 'Update',
      ),
      SizedBox(height: 20),
      _buildButton(
        onPressed: () {
          Navigator.pop(_ctx);
        },
        title: 'Cancel',
      ),
    ]),
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
              color: Color.fromRGBO(28, 20, 120, 1),
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

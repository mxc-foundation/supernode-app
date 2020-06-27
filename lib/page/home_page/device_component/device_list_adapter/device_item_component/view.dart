import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    DeviceItemState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  return Container(
    padding: const EdgeInsets.only(bottom: 2),
    decoration: BoxDecoration(
      border: Border(
          bottom: BorderSide(color: Color.fromARGB(26, 0, 0, 0), width: 1)),
    ),
    child: ListTile(
      onTap: (){
        Navigator.pushNamed(_ctx, 'smart_watch_detail_page');
      },
      // onTap: () => dispatch(GatewayItemActionCreator.onProfile()),
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.lens,
                  color: true ? Colors.green : Colors.grey,
                  size: 10,
                ),
                SizedBox(width: 5),
                Text(
                    true
                        ? '(${FlutterI18n.translate(_ctx, 'online')})'
                        : '(${FlutterI18n.translate(_ctx, 'offline')})',
                    style: kSmallFontOfGrey),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.camera_enhance,
                        size: 20,
                      ),
                      Icon(
                        Icons.watch,
                        size: 20,
                      ),
                      Icon(
                        Icons.vpn_key,
                        size: 20,
                      ),
                      Icon(
                        Icons.directions_car,
                        size: 20,
                      ),
                      SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          'AI Camera Name AI Camera NameAI Camera Name here…',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kBigFontOfBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  FlutterI18n.translate(_ctx, 'downlink_fee'),
                  style: kBigFontOfGrey,
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${FlutterI18n.translate(_ctx, 'last_seen')}: 2020-05-19 09:39:12',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kSmallFontOfGrey,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(51, 77, 137, 229),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Text(
                    '10 MXC',
                    style: kBigFontOfBlack,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

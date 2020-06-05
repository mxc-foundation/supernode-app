import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(GatewayItemState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Container(
    height: 100,
    padding: const EdgeInsets.only(bottom: 2),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color.fromARGB(26, 0, 0, 0),
          width: 1
        )
      ),
    ),
    child: ListTile(
      // onTap: () => dispatch(GatewayItemActionCreator.onProfile()),
      title: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                state.name,
                textAlign: TextAlign.left,
                style: kBigFontOfBlack
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${FlutterI18n.translate(_ctx,'last_seen')}: ${TimeDao.getDatetime(state.lastSeenAt)}',
                      style: kSmallFontOfGrey,
                    ),
                    Container(
                      width: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              TimeDao.isIn5Min(state.lastSeenAt) ?
                              '(${FlutterI18n.translate(_ctx,'online')})' : '(${FlutterI18n.translate(_ctx,'offline')})',
                              style: kSmallFontOfGrey
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,top: 4),
                            child: Icon(
                              Icons.lens,
                              color: TimeDao.isIn5Min(state.lastSeenAt) ? Colors.green : Colors.grey,
                              size: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${FlutterI18n.translate(_ctx,'version')}: ${state.description}',
                      style: kSmallFontOfGrey,
                    ),
                    Text(
                      '${FlutterI18n.translate(_ctx,'gateway_id')}: ${state.id}',
                      style: kSmallFontOfGrey,
                    )
                  ]
                )
              )
            ],
          ),
          Spacer(),
          Align(
            alignment: Alignment.topRight,
            // margin: EdgeInsets.only(top: 1),
            child: Column(
              // verticalDirection: VerticalDirection.up,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        TimeDao.isIn5Min(state.lastSeenAt) ? 
                        '(${FlutterI18n.translate(_ctx,'online')})' : '(${FlutterI18n.translate(_ctx,'offline')})',
                        style: kSmallFontOfGrey
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5,top: 4),
                        child: Icon(
                          Icons.lens,
                          color: TimeDao.isIn5Min(state.lastSeenAt) ? Colors.green : Colors.grey,
                          size: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${FlutterI18n.translate(_ctx,'downlink_price')}',
                  style: kSmallFontOfGrey,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(51, 77, 137, 229),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Text(
                    '${state.location["accuracy"]} MXC',
                    style: kBigFontOfBlack,
                  ),
                ),
              ]
            )
          )
        ]
      ),
    ),
  );
}

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/page/home_page/device_component/action.dart';

import '../action.dart';
import 'state.dart';

Widget buildView(
    DeviceState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  final ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: homeBar(
      FlutterI18n.translate(_ctx, 'device'),
      onPressed: () => dispatch(HomeActionCreator.onSettings()),
    ),
    body: RefreshIndicator(
      displacement: 10,
      onRefresh: () async {
      },
      child: pageBody(
        children: [
          panelFrame(
            child: panelBody(
                loading: false,
                icon: Icons.add_circle,
                onPressed: () {
                 dispatch( DeviceActionCreator.onQrScan());
                },
                titleText: FlutterI18n.translate(_ctx, 'total_device'),
                subtitleText: '4',
                trailTitle: FlutterI18n.translate(_ctx, 'downlink_fee'),
                trailSubtitle: '22 MXC (22 USD)'),
          ),
          panelFrame(
            child: adapter.itemCount != 0
                ? ListView.builder(
                    itemBuilder: adapter.itemBuilder,
                    itemCount: adapter.itemCount,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  )
                : empty(_ctx),
          ),
//          panelFrame(
//            child: empty(_ctx),
//          ),
//          panelFrame(
//            child: LoadingList(),
//          ),
        ],
      ),
    ),
  );
}

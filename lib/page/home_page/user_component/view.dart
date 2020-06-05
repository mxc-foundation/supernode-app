import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/map.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/profile.dart';
import 'package:supernodeapp/common/components/row_right.dart';
import 'package:supernodeapp/common/components/summary_row.dart';
import 'package:supernodeapp/common/configs/images.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/page/home_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(UserState state, Dispatch dispatch, ViewService viewService) {
  final _ctx = viewService.context;

  return Scaffold(
    appBar: AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Image.asset(
        AppImages.superNodes[state.selectedSuperNode],
        height: 40,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.black,
          ),
          onPressed: () => dispatch(HomeActionCreator.onSettings()),
        )
      ],
    ),
    body: RefreshIndicator(
      displacement: 10,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2), () {
          dispatch(HomeActionCreator.onProfile());
        });
      },
      child: pageBody(
        children: [
          panelFrame(
            child: Column(
              children: [
                profile(
                  name: '${FlutterI18n.translate(_ctx, 'hi')}, ${state.username}',
                  position: (state.organizations.length > 0 && state.organizations.first.isAdmin)
                      ? FlutterI18n.translate(_ctx, 'admin')
                      : '',
                ),
                rowRight(FlutterI18n.translate(_ctx, 'current_balance'), style: kSmallFontOfGrey),
                rowRight('${Tools.priceFormat(state.balance)} MXC', style: kBigFontOfBlack),
                rowRight(FlutterI18n.translate(_ctx, 'staked_amount'), style: kSmallFontOfGrey),
                rowRight('${Tools.priceFormat(state.stakedAmount)} MXC', style: kBigFontOfBlack),
                Container(
                  margin: kRoundRow5,
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      PrimaryButton(
                        buttonTitle: FlutterI18n.translate(_ctx, 'deposit'),
                        onTap: () => dispatch(HomeActionCreator.onOperate('deposit')),
                      ),
                      Spacer(),
                      PrimaryButton(
                        buttonTitle: FlutterI18n.translate(_ctx, 'withdraw'),
                        onTap: () => dispatch(HomeActionCreator.onOperate('withdraw')),
                      ),
                      Spacer(),
                      PrimaryButton(
                        buttonTitle: FlutterI18n.translate(_ctx, 'stake'),
                        onTap: () => dispatch(HomeActionCreator.onOperate('stake')),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          panelFrame(
            child: summaryRow(
              image: AppImages.gateways,
              title: FlutterI18n.translate(_ctx, 'total_gateways'),
              number: '${state.gatewaysTotal}',
              subtitle: FlutterI18n.translate(_ctx, 'profit'),
              price:
                  '${Tools.priceFormat(state.gatewaysRevenue)} MXC (${Tools.priceFormat(state.gatewaysUSDRevenue)} USD)',
            ),
          ),
          panelFrame(
            child: summaryRow(
              image: AppImages.devices,
              title: FlutterI18n.translate(_ctx, 'total_devices'),
              number: '${state.devicesTotal}',
              subtitle: FlutterI18n.translate(_ctx, 'cost'),
              price:
                  '${Tools.priceFormat(state.devicesRevenue)} MXC (${Tools.priceFormat(state.devicesUSDRevenue)} USD)',
            ),
          ),
          MapWidget(
            context: _ctx,
            userLocationSwitch: true,
            markers: state.gatewaysLocations ?? [],
            controller: state.mapCtl,
            callback: (location) => dispatch(UserActionCreator.addLocation(location)),
            zoomOutCallback: () => dispatch(HomeActionCreator.mapbox()),
            myLatLng: state.location,
          ),
          smallColumnSpacer(),
        ],
      ),
    ),
  );
}

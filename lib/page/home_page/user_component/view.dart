import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mapbox_native/flutter_mapbox_native.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/profile.dart';
import 'package:supernodeapp/common/components/row_right.dart';
import 'package:supernodeapp/common/components/summary_row.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'state.dart';

bool isUpdate = true;

Widget buildView(UserState state, Dispatch dispatch, ViewService viewService) {
  final _ctx = viewService.context;

  return Scaffold(
    appBar: AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: CachedNetworkImage(
        imageUrl: "${GlobalStore?.state?.superModel?.currentNode?.logo}",
        placeholder: (a, b) => Image.asset(
          AppImages.placeholder,
          height: s(40),
        ),
        height: s(40),
      ),
      actions: [
        IconButton(
          key: Key('settingsButton'),
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
        await Future.delayed(Duration(seconds: 1), () {
          dispatch(HomeActionCreator.onProfile());
        });
      },
      child: pageBody(
        children: [
          panelFrame(
            child: Column(
              children: [
                profile(
                  name:
                      '${FlutterI18n.translate(_ctx, 'hi')}, ${state.username}',
                  position: (state.organizations.length > 0 &&
                          state.organizations.first.isAdmin)
                      ? FlutterI18n.translate(_ctx, 'admin')
                      : '',
                  trailing: SizedBox(
                    width: 30,
                    child: IconButton(
                      key: ValueKey('calculatorButton'),
                      icon: FaIcon(
                        FontAwesomeIcons.calculator,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.of(_ctx)
                          .pushNamed('calculator_page', arguments: {
                        'balance': state.balance,
                        'staking': state.stakedAmount,
                        'mining': state.gatewaysRevenue + state.devicesRevenue,
                        'isDemo': state.isDemo,
                      }),
                      iconSize: 20,
                    ),
                  ),
                ),
                rowRight(
                  FlutterI18n.translate(_ctx, 'current_balance'),
                  style: kSmallFontOfGrey,
                ),
                rowRight(
                  '${Tools.priceFormat(state.balance)} MXC',
                  style: kBigFontOfBlack,
                  loading: !state.loadingMap.contains('balance'),
                ),
                rowRight(
                  FlutterI18n.translate(_ctx, 'staked_amount'),
                  style: kSmallFontOfGrey,
                ),
                rowRight(
                  '${Tools.priceFormat(state.stakedAmount)} MXC',
                  style: kBigFontOfBlack,
                  loading: !state.loadingMap.contains('stakedAmount'),
                ),
                rowRight(
                  FlutterI18n.translate(_ctx, 'staking_revenue'),
                  style: kSmallFontOfGrey,
                ),
                rowRight(
                  '${Tools.priceFormat(state.totalRevenue, range: 2)} MXC',
                  style: kBigFontOfBlack,
                  loading: !state.loadingMap.contains('totalRevenue'),
                ),
                Container(
                  margin: kRoundRow5,
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      PrimaryButton(
                        key: Key('depositButtonDashboard'),
                        buttonTitle: FlutterI18n.translate(_ctx, 'deposit'),
                        onTap: () =>
                            dispatch(HomeActionCreator.onOperate('deposit')),
                      ),
                      Spacer(),
                      PrimaryButton(
                        key: Key('withdrawButtonDashboard'),
                        buttonTitle: FlutterI18n.translate(_ctx, 'withdraw'),
                        onTap: () =>
                            dispatch(HomeActionCreator.onOperate('withdraw')),
                      ),
                      Spacer(),
                      PrimaryButton(
                        key: Key('stakeButtonDashboard'),
                        buttonTitle: FlutterI18n.translate(_ctx, 'stake'),
                        onTap: () =>
                            dispatch(HomeActionCreator.onOperate('stake')),
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
              key: Key('totalGatewaysDashboard'),
              loading: !state.loadingMap.contains('gatewaysUSD'),
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
              loading: false,
              image: AppImages.devices,
              title: FlutterI18n.translate(_ctx, 'total_devices'),
              number: '${state.devicesTotal}',
              subtitle: FlutterI18n.translate(_ctx, 'cost'),
              price:
                  '${Tools.priceFormat(state.devicesRevenue)} MXC (${Tools.priceFormat(state.devicesUSDRevenue)} USD)',
            ),
          ),
          // panelFrame(
          //   height: 263,
          //   child: FutureBuilder(
          //     builder: (context,builder) {
          //       return MapBoxGLWidget(
          //         markers: state.geojsonList,
          //         onFullScreenPress: () => dispatch(HomeActionCreator.mapbox())
          //       ) ?? SizedBox(
          //         width: 0,
          //         height: 0,
          //       );
          //     },
          //   )
          // ),
          panelFrame(
            height: 263,
            child: FutureBuilder(
              builder: (context,builder) {
                return FlutterMapboxNative(
                  mapStyle: Sys.mapTileStyle,
                  center: CenterPosition(
                    target: LatLng(0,0),
                    zoom: 0,
                    animated: true,
                  ),
                  // minimumZoomLevel: 1,
                  maximumZoomLevel: 12, 
                  clusters: state.geojsonList,
                  myLocationEnabled: true,
                  myLocationTrackingMode: MyLocationTrackingMode.None,
                  onFullScreenTap: () => dispatch(HomeActionCreator.mapbox())
                );
              }
            )

          ),
          smallColumnSpacer(),
        ],
      ),
    ),
  );
}
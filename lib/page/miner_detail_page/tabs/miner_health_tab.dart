import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/widgets/circular_graph.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.model.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/add_fuel_page/add_fuel_page.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/home_page/shared.dart';
import 'package:supernodeapp/page/send_to_wallet_page/send_to_wallet_page.dart';
import 'package:supernodeapp/page/home_page/gateway/view_all_page/bloc/state.dart';
import 'package:supernodeapp/page/home_page/gateway/view_all_page/view.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

import '../graph_card.dart';
import '../title.dart';

class MinerHealthTab extends StatelessWidget {
  final GatewayItem item;
  final List<DailyStatistic> healthStatisticsData;
  final int sumSecondsOnlineLast7days;
  final int secondsLast7days;
  final VoidCallback onRefresh;

  const MinerHealthTab({
    Key key,
    this.item,
    this.healthStatisticsData,
    this.sumSecondsOnlineLast7days,
    this.secondsLast7days,
    this.onRefresh,
  }) : super(key: key);

  Widget infoCard(
    BuildContext context, {
    @required Widget image,
    @required int value,
    @required String title,
    @required String description,
    @required String comment,
    bool enabled = false,
  }) =>
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorsTheme.of(context).textSecondary),
          boxShadow: [
            BoxShadow(
              color: boxShadowColor,
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  foregroundDecoration: enabled
                      ? null
                      : BoxDecoration(
                          color: ColorsTheme.of(context).textLabel,
                          shape: BoxShape.circle,
                          backgroundBlendMode: BlendMode.saturation,
                        ),
                  child: image,
                ),
                Text(
                  '$value%',
                  textAlign: TextAlign.center,
                  style: enabled
                      ? FontTheme.of(context).big.mxc()
                      : FontTheme.of(context).big.secondary(),
                ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: enabled
                        ? FontTheme.of(context).big.mxc()
                        : FontTheme.of(context).big.secondary(),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: enabled
                        ? FontTheme.of(context).middle()
                        : FontTheme.of(context).middle.secondary(),
                  ),
                  SizedBox(height: 4),
                  Text(comment,
                      style: FontTheme.of(context).middle.secondary()),
                ],
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 16),
            GestureDetector(
              onTap: item.health == 1
                  ? null
                  : () => Navigator.of(context)
                      .push(routeWidget(AddFuelPage(gatewayItem: item)))
                      .then((value) => onRefresh()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: ColorsTheme.of(context).boxComponents,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: boxShadowColor,
                          spreadRadius: 0,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Image.asset(
                      AppImages.fuel,
                      color: item.health == 1
                          ? ColorsTheme.of(context).textLabel
                          : ColorsTheme.of(context).minerHealthRed,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(FlutterI18n.translate(context, 'add')),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CircularGraph(
                  (item.health ?? 0) * 100,
                  (item.health ?? 0) <= 0.1 
                      ? ColorsTheme.of(context).minerHealthRed
                      : ColorsTheme.of(context).mxcBlue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${((item.health ?? 0) * 100).round()}%',
                          style: FontTheme.of(context).veryBig.primary.bold()),
                      Text(
                        FlutterI18n.translate(context, 'health_score'),
                        style: FontTheme.of(context).middle.secondary(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: item.miningFuel != null && item.miningFuel > Decimal.zero
                  ? () => Navigator.of(context)
                      .push(routeWidget(SendToWalletPage(gatewayItem: item)))
                      .then((value) => onRefresh())
                  : null,
              child: Column(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: ColorsTheme.of(context).boxComponents,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: boxShadowColor,
                          spreadRadius: 0,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Container(
                      child: Icon(
                        Icons.arrow_forward,
                        color: item.miningFuel != null && item.miningFuel > Decimal.zero
                            ? ColorsTheme.of(context).minerHealthRed
                            : ColorsTheme.of(context).textLabel,
                        size: 26,
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(FlutterI18n.translate(context, 'send')),
                ],
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
        SizedBox(height: 16),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.fuel,
                color: ColorsTheme.of(context).minerHealthRed,
              ),
              SizedBox(width: 10),
              item.miningFuel != null
                  ? Text(
                      '${Tools.priceFormat(item.miningFuel.toDouble())} / ${Tools.priceFormat(item.miningFuelMax.toDouble())} MXC',
                      style: FontTheme.of(context).big())
                  : Text('0.0 / 0.0 MXC', style: FontTheme.of(context).big())
            ],
          ),
        ),
        SizedBox(height: 16),
        StatisticTable(item: item),
        MinerDetailTitle(
          FlutterI18n.translate(context, 'uptime'),
          action: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                FlutterI18n.translate(context, 'see_more'),
                style: FontTheme.of(context).small.mxc(),
              ),
            ),
            onTap: () => Navigator.of(context).push(routeWidget(ViewAllPage(
                  minerId: item.id,
                  type: MinerStatsType.uptime,
                ))),
          ),
        ),
        GraphCard(
          online: item.lastSeenAt != null ? DateTime.tryParse(item.lastSeenAt)
                  .difference(DateTime.now())
                  .abs() <
              Duration(minutes: 5) : false,
          lastSeen: DateTime.tryParse(item.lastSeenAt ?? ''),
          maxValue: 1,
          subtitle: FlutterI18n.translate(context, 'score_weekly_total'),
          title:
              '${(sumSecondsOnlineLast7days / secondsLast7days * 100.0).round()}% (${(sumSecondsOnlineLast7days / (60 * 60)).round()}h)',
          entities: healthStatisticsData
              ?.map((e) =>
                  GraphEntity(e.date, e.onlineSeconds / (24 * 60 * 60.0)))
              ?.toList(),
          startDate: healthStatisticsData?.first?.date,
          endDate: healthStatisticsData?.last?.date,
        ),
        SizedBox(height: 8),
        MinerDetailTitle(
          'GPS',
          action: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                FlutterI18n.translate(context, 'view_map'),
                style: FontTheme.of(context).small.secondary(),
              ),
            ),
            onTap: () {},
          ),
        ),
        infoCard(
          context,
          image: Image.asset(AppImages.gps),
          value: 100,
          title: FlutterI18n.translate(context, 'gps_card_title'),
          description: FlutterI18n.translate(context, 'gps_card_description'),
          comment: FlutterI18n.translate(context, 'gps_card_comment'),
        ),
        SizedBox(height: 8),
        MinerDetailTitle(FlutterI18n.translate(context, 'altitude')),
        infoCard(
          context,
          image: Image.asset(AppImages.altitude),
          value: 100,
          title: FlutterI18n.translate(context, 'altitude_card_title'),
          description:
              FlutterI18n.translate(context, 'altitude_card_description')
                  .replaceAll('{0}', '5'),
          comment: FlutterI18n.translate(context, 'altitude_card_comment'),
        ),
        SizedBox(height: 8),
        MinerDetailTitle(FlutterI18n.translate(context, 'proximity')),
        infoCard(
          context,
          image: Image.asset(AppImages.proximity),
          value: 100,
          title: FlutterI18n.translate(context, 'proximity_card_title'),
          description:
              FlutterI18n.translate(context, 'proximity_card_description')
                  .replaceAll('{0}', '4'),
          comment: FlutterI18n.translate(context, 'proximity_card_comment'),
        ),
        SizedBox(height: 8),
        MinerDetailTitle(FlutterI18n.translate(context, 'orientation')),
        infoCard(
          context,
          image: Image.asset(AppImages.orientation),
          value: 100,
          title: FlutterI18n.translate(context, 'orientation_card_title'),
          description:
              FlutterI18n.translate(context, 'orientation_card_description')
                  .replaceAll('{0}', '0'),
          comment: FlutterI18n.translate(context, 'orientation_card_comment'),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}

class StatisticTable extends StatelessWidget {
  final GatewayItem item;

  const StatisticTable({Key key, this.item}) : super(key: key);

  Widget _statisticItem(BuildContext context, String title, String value,
          {Function onTap}) =>
      Expanded(
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: FontTheme.of(context).small.secondary(),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: value == '-'
                    ? FontTheme.of(context).big.secondary()
                    : FontTheme.of(context).big.mxc(),
              ),
            ],
          ),
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsTheme.of(context).boxComponents,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _statisticItem(
                context,
                FlutterI18n.translate(context, 'uptime'),
                '${((item.uptimeHealth ?? 0) * 100).round()}%',
                onTap: () => aboutPage(
                    context,
                    FlutterI18n.translate(context, 'uptime'),
                    aboutPageIllustration(
                      context,
                      FlutterI18n.translate(context, 'uptime'),
                      Image.asset(AppImages.uptime,
                          width: s(60), fit: BoxFit.contain),
                    ),
                    FlutterI18n.translate(context, 'uptime_info')),
              ),
              _statisticItem(
                context,
                FlutterI18n.translate(context, 'gps'),
                '-',
                onTap: () => aboutPage(
                    context,
                    FlutterI18n.translate(context, 'gps'),
                    aboutPageIllustration(
                        context,
                        FlutterI18n.translate(context, 'gps'),
                        Image.asset(AppImages.gps,
                            width: s(60), fit: BoxFit.contain)),
                    FlutterI18n.translate(context, 'gps_info')),
              ),
              _statisticItem(
                context,
                FlutterI18n.translate(context, 'altitude'),
                '-',
                onTap: () => aboutPage(
                    context,
                    FlutterI18n.translate(context, 'altitude'),
                    aboutPageIllustration(
                        context,
                        FlutterI18n.translate(context, 'altitude'),
                        Image.asset(AppImages.altitude,
                            width: s(60), fit: BoxFit.contain)),
                    FlutterI18n.translate(context, 'altitude_info')),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _statisticItem(
                context,
                FlutterI18n.translate(context, 'proximity'),
                '-',
                onTap: () => aboutPage(
                    context,
                    FlutterI18n.translate(context, 'proximity'),
                    aboutPageIllustration(
                        context,
                        FlutterI18n.translate(context, 'proximity'),
                        Image.asset(AppImages.proximity,
                            width: s(60), fit: BoxFit.contain)),
                    FlutterI18n.translate(context, 'proximity_info')),
              ),
              _statisticItem(
                context,
                FlutterI18n.translate(context, 'orientation'),
                '-',
                onTap: () => aboutPage(
                    context,
                    FlutterI18n.translate(context, 'orientation'),
                    aboutPageIllustration(
                        context,
                        FlutterI18n.translate(context, 'orientation'),
                        Image.asset(AppImages.orientation,
                            width: s(60), fit: BoxFit.contain)),
                    FlutterI18n.translate(context, 'orientation_info')),
              ),
              _statisticItem(
                context,
                FlutterI18n.translate(context, 'fuel'),
                '${((item.miningFuelHealth ?? 0) * 100).round()}%',
                onTap: () => aboutPage(
                    context,
                    FlutterI18n.translate(context, 'fuel'),
                    aboutPageIllustration(
                      context,
                      FlutterI18n.translate(context, 'fuel'),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            AppImages.uptime,
                            color: ColorsTheme.of(context).textPrimaryAndIcons,
                            width: s(60),
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            AppImages.fuel,
                            color: ColorsTheme.of(context).minerHealthRed,
                            width: s(20),
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    FlutterI18n.translate(context, 'fuel_info')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/widgets/circular_graph.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.model.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import '../graph_card.dart';
import '../title.dart';

class MinerHealthTab extends StatelessWidget {
  final GatewayItem item;
  final List<DailyStatistic> health;
  final double averageHealth;

  const MinerHealthTab({
    Key key,
    this.item,
    this.health,
    this.averageHealth,
  }) : super(key: key);

  Widget infoCard({
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
          color: Colors.white.withOpacity(enabled ? 1 : 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
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
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                          backgroundBlendMode: BlendMode.saturation,
                        ),
                  child: image,
                ),
                Text(
                  '$value%',
                  textAlign: TextAlign.center,
                  style: enabled ? kBigFontOfDarkBlue : kBigFontOfGrey,
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
                    style: enabled ? kBigFontOfDarkBlue : kBigFontOfGrey,
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: enabled ? kMiddleFontOfBlack : kMiddleFontOfGrey,
                  ),
                  SizedBox(height: 4),
                  Text(comment, style: kMiddleFontOfGrey),
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
              child: Column(
                children: [
                  Image.asset(AppImages.fuelCircle),
                  Text(FlutterI18n.translate(context, 'add')),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CircularGraph(
                  item.health * 100,
                  fuelColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${(item.health * 100).round()}%',
                          style: kSuperBigBoldFont),
                      Text(
                        FlutterI18n.translate(context, 'health_score'),
                        style: kMiddleFontOfGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Column(
                children: [
                  Image.asset(AppImages.sendCircle),
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
                color: healthColor,
              ),
              SizedBox(width: 10),
              Text(
                '${Tools.priceFormat(item.miningFuel.toDouble())} / ${Tools.priceFormat(item.miningFuelMax.toDouble())} MXC',
                style: kBigFontOfBlack,
              )
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
                style: kSmallFontOfDarkBlue,
              ),
            ),
            onTap: () {},
          ),
        ),
        GraphCard(
          online: DateTime.tryParse(item.lastSeenAt)
                  .difference(DateTime.now())
                  .abs() <
              Duration(minutes: 5),
          lastSeen: DateTime.tryParse(item.lastSeenAt),
          maxValue: 1,
          subtitle: FlutterI18n.translate(context, 'score_weekly'),
          title:
              '${(averageHealth * 100).round()}% (${(averageHealth * (health?.length ?? 0) * 24).toInt()}h)',
          entities: health?.map((e) => GraphEntity(e.date, e.health))?.toList(),
          startDate: health?.first?.date,
          endDate: health?.last?.date,
        ),
        SizedBox(height: 8),
        MinerDetailTitle(
          'GPS',
          action: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                FlutterI18n.translate(context, 'view_map'),
                style: kSmallFontOfDarkBlue,
              ),
            ),
            onTap: () {},
          ),
        ),
        infoCard(
          image: Image.asset(AppImages.gps),
          value: 100,
          title: FlutterI18n.translate(context, 'gps_card_title'),
          description: FlutterI18n.translate(context, 'gps_card_description'),
          comment: FlutterI18n.translate(context, 'gps_card_comment'),
        ),
        SizedBox(height: 8),
        MinerDetailTitle(FlutterI18n.translate(context, 'altitude')),
        infoCard(
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

  Widget _statisticItem(String title, int value) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: kSmallFontOfGrey,
            ),
            SizedBox(height: 8),
            Text(
              '$value%',
              style: kBigFontOfDarkBlue,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorMxc.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _statisticItem(
                FlutterI18n.translate(context, 'uptime'),
                ((item.uptimeHealth ?? 0) * 100).round(),
              ),
              _statisticItem(FlutterI18n.translate(context, 'gps'), 100),
              _statisticItem(FlutterI18n.translate(context, 'altitude'), 100),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _statisticItem(FlutterI18n.translate(context, 'proximity'), 100),
              _statisticItem(
                  FlutterI18n.translate(context, 'orientation'), 100),
              _statisticItem(
                FlutterI18n.translate(context, 'fuel'),
                ((item.miningFuelHealth ?? 0) * 100).round(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
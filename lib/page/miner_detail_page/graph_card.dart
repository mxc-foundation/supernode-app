import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:supernodeapp/common/components/widgets/bar_graph.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class GraphEntity {
  final DateTime date;
  final num value;

  GraphEntity(this.date, this.value);
}

class GraphCard extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final bool online;
  final String title;
  final String subtitle;
  final DateTime lastSeen;
  final List<GraphEntity> entities;
  final num maxValue;

  const GraphCard({
    Key key,
    @required this.startDate,
    @required this.endDate,
    this.online,
    @required this.title,
    @required this.subtitle,
    this.lastSeen,
    this.maxValue,
    @required this.entities,
  }) : super(key: key);

  @override
  _GraphCardState createState() => _GraphCardState();
}

class _GraphCardState extends State<GraphCard> {
  Widget uptimeGraph() {
    if (widget.entities == null)
      return Center(child: CircularProgressIndicator());

    final maxValue = widget.maxValue ??
        widget.entities.reduce((a, b) => a.value > b.value ? a : b).value;

    final weekdays = <String>[];
    final values = <double>[];
    for (final e in widget.entities) {
      final now = DateTime.now();
      if (DateTime(e.date.year, e.date.month, e.date.day) ==
          DateTime(now.year, now.month, now.day))
        weekdays.add(FlutterI18n.translate(context, 'today'));
      else
        weekdays.add(TimeUtil.weekDayShort(context)[e.date.weekday]);
      values.add(e.value / maxValue);
    }

    return BarGraph(
      values.reversed.toList(),
      7,
      MediaQuery.of(context).size.width - 70,
      xAxisLabels: weekdays.reversed.toList(),
    );
  }

  String getMD(DateTime date) =>
      '${TimeUtil.months(context)[date.month]} ${date.day}';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: EdgeInsets.all(16),
      height: 240,
      decoration: BoxDecoration(
        color: ColorsTheme.of(context).boxComponents,
        boxShadow: [
          BoxShadow(
            color: boxShadowColor,
            spreadRadius: 0,
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.subtitle ??
                      FlutterI18n.translate(context, 'score_weekly'),
                  style: FontTheme.of(context).middle.secondary(),
                ),
              ),
              if (widget.online == true) ...[
                Text(
                  FlutterI18n.translate(context, 'online'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 10,
                    height: 10,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ] else if (widget.online == false) ...[
                Text(
                  FlutterI18n.translate(context, 'offline'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 10,
                    height: 10,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorsTheme.of(context).textLabel,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title ?? '0% (0h)',
                  style: FontTheme.of(context).big.mxc(),
                ),
              ),
              Text(
                '${getMD(widget.startDate ?? DateTime.now())} - ${getMD(widget.endDate ?? DateTime.now())}',
                style: FontTheme.of(context).middle.secondary(),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(child: uptimeGraph()),
          if (widget.lastSeen != null) ...[
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  FlutterI18n.translate(context, 'last_seen'),
                  style: FontTheme.of(context).middle.secondary(),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    TimeUtil.getDatetime(widget.lastSeen),
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
          ],
        ],
      ),
    );
  }
}

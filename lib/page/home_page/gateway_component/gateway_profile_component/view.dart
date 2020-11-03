import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/page/introduction.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/daos/chart_dao.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/gateway_component/item_state.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_flutter/src/text_element.dart';

import 'state.dart';

Widget buildView(
    GatewayProfileState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  GatewayItemState profile = state.profile;
  final location = LatLng((profile.location['latitude'] as num).toDouble(),
      (profile.location['longitude'] as num).toDouble());

  return pageFrame(context: viewService.context, children: [
    pageNavBar(profile.name, onTap: () => Navigator.pop(viewService.context)),
    ListTile(
        contentPadding: kOuterRowTop20,
        title: Row(
          children: [
            Text(
              '${FlutterI18n.translate(_ctx, 'downlink_price')}',
              style: kBigFontOfBlack,
            ),
            GestureDetector(
              onTap: () => _showInfoDialog(viewService.context),
              child: Padding(
                key: Key("questionCircle"),
                padding: EdgeInsets.all(s(5)),
                child: Image.asset(AppImages.questionCircle, height: s(20)),
              ),
            )
          ],
        ),
        trailing: Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
            color: Color.fromARGB(51, 77, 137, 229),
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: Text(
            '${profile.location["accuracy"]} MXC',
            style: kBigFontOfBlack,
          ),
        )),
    MapBoxWidget(
      rowTop: EdgeInsets.zero,
      config: state.mapCtl,
      centerLocation: location,
      userLocationSwitch: false,
      isUserLocation: false,
      isUserLocationSwitch: false,
    ),
    ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          '${profile.location['altitude']} meters',
          style: kMiddleFontOfGrey,
        ),
        trailing: Text(
          '${profile.location['latitude']},${profile.location['longitude']}',
          style: kMiddleFontOfGrey,
        )),
    paragraph(FlutterI18n.translate(_ctx, 'gateway_id')),
    introduction(profile.id ?? '', top: 5),
    paragraph(FlutterI18n.translate(_ctx, 'last_seen')),
    introduction(TimeDao.getDatetime(profile.lastSeenAt) ?? '', top: 5),
    Padding(
      padding: kOuterRowTop35,
      child: paragraph(FlutterI18n.translate(_ctx, 'weekly_revenue')),
    ),
    Center(
      child: Container(
        width: 300,
        height: 300,
        child: MiningChart(
          state.miningRevenve,
          key: ValueKey('miningChart'),
        ),
      ),
    ),
    paragraph(FlutterI18n.translate(_ctx, 'frame')),
    Center(
      child: Container(
        width: 300,
        height: 300,
        child: charts.BarChart(
          GatewayFrame.getData(state.gatewayFrame),
          animate: true,
          barGroupingType: charts.BarGroupingType.grouped,
          behaviors: [new charts.SeriesLegend()],
        ),
      ),
    ),
    paragraph(FlutterI18n.translate(_ctx, 'gateway_model')),
    introduction(profile.model ?? '', top: 5),
    paragraph(FlutterI18n.translate(_ctx, 'gateway_osversion')),
    introduction(profile.osversion ?? '', top: 5),
  ]);
}

class MiningChart extends StatefulWidget {
  final List miningRevenue;
  MiningChart(this.miningRevenue, {Key key}) : super(key: key);

  @override
  _MiningChartState createState() => _MiningChartState();
}

class _MiningChartState extends State<MiningChart> {
  List _miningRevenue;
  CustomCircleSymbolRenderer _renderer;

  @override
  void initState() {
    _miningRevenue = widget.miningRevenue;
    _renderer = CustomCircleSymbolRenderer(0);
    super.initState();
  }

  @override
  void didUpdateWidget(MiningChart oldWidget) {
    if (oldWidget.miningRevenue != widget.miningRevenue) {
      setState(() => _miningRevenue = widget.miningRevenue);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      Mining.getData(_miningRevenue),
      animate: true,
      defaultRenderer: charts.LineRendererConfig(includePoints: true),
      behaviors: [
        charts.LinePointHighlighter(
          symbolRenderer: _renderer,
        )
      ],
      selectionModels: [
        charts.SelectionModelConfig(
          changedListener: (charts.SelectionModel model) {
            if (model.hasDatumSelection) {
              _renderer.value = model.selectedSeries[0]
                  .measureFn(model.selectedDatum[0].index);
            }
          },
        ),
      ],
    );
  }
}

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  double value;
  CustomCircleSymbolRenderer(this.value);

  @override
  void paint(
    charts.ChartCanvas canvas,
    Rectangle<num> bounds, {
    List<int> dashPattern,
    charts.Color fillColor,
    charts.FillPatternType fillPattern,
    charts.Color strokeColor,
    double strokeWidthPx,
  }) {
    super.paint(
      canvas,
      bounds,
      dashPattern: dashPattern,
      fillColor: fillColor,
      strokeColor: strokeColor,
      strokeWidthPx: strokeWidthPx,
    );
    final val = value.toStringAsFixed(0);
    Rectangle rect;
    int xTextOffset;
    if (val.length >= 4) {
      rect = Rectangle(
        bounds.left - 13,
        bounds.top - 30,
        bounds.width + 25,
        bounds.height + 10,
      );
      xTextOffset = (bounds.left - 11).round();
    }
    if (val.length == 3) {
      rect = Rectangle(
        bounds.left - 13,
        bounds.top - 30,
        bounds.width + 25,
        bounds.height + 10,
      );
      xTextOffset = (bounds.left - 7).round();
    }
    if (val.length == 2) {
      rect = Rectangle(
        bounds.left - 13,
        bounds.top - 30,
        bounds.width + 25,
        bounds.height + 10,
      );
      xTextOffset = (bounds.left - 3).round();
    }
    if (val.length <= 1) {
      rect = Rectangle(
        bounds.left - 13,
        bounds.top - 30,
        bounds.width + 25,
        bounds.height + 10,
      );
      xTextOffset = (bounds.left + 2).round();
    }
    canvas.drawRect(
      rect,
      fill: charts.Color.fromHex(code: "#808080"),
    );
    var textStyle = style.TextStyle();
    textStyle.color = charts.Color.white;
    textStyle.fontSize = 15;
    final el = TextElement(val, style: textStyle);
    canvas.drawText(el, xTextOffset, (bounds.top - 28).round());
  }
}

void _showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FullScreenDialog(
        child: IosStyleBottomDialog2(
            context: context,
            child: Column(
              children: [
                Image.asset(AppImages.infoDownlinkPrice, height: s(80)),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      FlutterI18n.translate(context, 'info_downlink_price'),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: s(16),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                ),
              ],
            )
        ),
      );
    },
  );
}



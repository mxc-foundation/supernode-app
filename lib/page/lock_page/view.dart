import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/row_spacer.dart';
import 'package:supernodeapp/common/components/wallet/mining_tutorial.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(LockState state, Dispatch dispatch, ViewService viewService) {
  var context = viewService.context;

  return Scaffold(
    key: state.scaffoldKey,
    appBar: AppBars.backArrowAppBar(
        title: FlutterI18n.translate(context, 'lock_mxc'),
        onPress: () => Navigator.pop(context)),
    body: SafeArea(
      child: Container(
        constraints: BoxConstraints.expand(),
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 239, 242),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(FlutterI18n.translate(context, 'lock_mxc'),
                    style: kBigBoldFontOfBlack),
                smallRowSpacer(),
                GestureDetector(
                  onTap: () => _showInfoDialog(context),
                  child: Padding(
                    key: Key("questionCircle"),
                    padding: EdgeInsets.all(s(5)),
                    child: Image.asset(AppImages.questionCircle, height: s(20)),
                  ),
                )
              ],
            ),
            smallColumnSpacer(),
            Text(FlutterI18n.translate(context, 'lock_tip'),
                style: kMiddleFontOfGrey),
            smallColumnSpacer(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: FlutterI18n.translate(context, 'learn_more'),
                    style: kMiddleFontOfBlueLink.copyWith(
                        color: Token.supernodeDhx.color),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          Navigator.push(context, MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return Scaffold(
                                appBar: AppBars.backArrowSkipAppBar(
                                    title: FlutterI18n.translate(
                                        context, 'tutorial_title'),
                                    onPress: () => Navigator.pop(context),
                                    action:
                                        FlutterI18n.translate(context, "skip")),
                                body: MiningTutorial(context),
                              );
                            },
                          )),
                  ),
                ],
              ),
            ),
            middleColumnSpacer(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _lockCard(
                    key: ValueKey('lock24'),
                    state: state,
                    context: context,
                    dispatch: dispatch,
                    months: 24,
                    color: lock24Color,
                    boostText: state.boost24m == null
                        ? null
                        : '${percentage(state.boost24m)}% ' +
                            FlutterI18n.translate(context, 'mining_boost'),
                    first: true,
                    boostRate: state.boost24m,
                  ),
                  _lockCard(
                    key: ValueKey('lock12'),
                    state: state,
                    context: context,
                    months: 12,
                    color: lock12Color,
                    boostText: state.boost12m == null
                        ? null
                        : '${percentage(state.boost12m)}% ' +
                            FlutterI18n.translate(context, 'mining_boost'),
                    boostRate: state.boost12m,
                  ),
                  _lockCard(
                    key: ValueKey('lock9'),
                    state: state,
                    context: context,
                    months: 9,
                    color: lock9Color,
                    boostText: state.boost9m == null
                        ? null
                        : '${percentage(state.boost9m)}% ' +
                            FlutterI18n.translate(context, 'mining_boost'),
                    boostRate: state.boost9m,
                  ),
                  _lockCard(
                    key: ValueKey('lock3'),
                    state: state,
                    context: context,
                    months: 3,
                    color: lock3Color,
                    boostText:
                        FlutterI18n.translate(context, 'minimum_duration'),
                    boostRate: state.boost3m,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

void _showInfoDialog(BuildContext context) {
  showInfoDialog(
    context,
    IosStyleBottomDialog2(
      builder: (context) => Column(
        children: [
          Image.asset(AppImages.infoMXCVault, height: s(80)),
          Padding(
            key: Key('helpText'),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              FlutterI18n.translate(context, 'info_mxc_lock'),
              style: TextStyle(
                color: blackColor,
                fontSize: s(16),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

int percentage(double v) {
  return (v * 100).round();
}

Widget _lockCard({
  BuildContext context,
  LockState state,
  int months,
  Color color,
  String boostText,
  double boostRate,
  bool first = false,
  Dispatch dispatch,
  Key key,
}) {
  return PanelFrame(
    rowTop: first ? EdgeInsets.only(top: 10) : null,
    child: ListTile(
      key: key,
      onTap: () async {
        if (boostRate == null) return;
        final res = await Navigator.of(context)
            .pushNamed('prepare_lock_page', arguments: {
          'isDemo': state.isDemo,
          'months': months,
          'boostRate': boostRate,
          'iconColor': color,
        });
        if (res == true) Navigator.of(context).pop(true);
      },
      leading: Container(
        height: 44,
        width: 44,
        alignment: Alignment.center,
        child: Text(
          months?.toString() ?? '~',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
        ),
        padding: EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
      title: Text(
        FlutterI18n.translate(context, 'dhx_month_lock')
            .replaceFirst('{0}', months.toString()),
      ),
      subtitle: Text(
        boostText == null ? '...' : boostText,
        style: kMiddleFontOfBlack.copyWith(
          color: Token.supernodeDhx.color,
          fontWeight: FontWeight.w600,
        ),
        key: Key('setBoost'),
      ),
    ),
  );
}

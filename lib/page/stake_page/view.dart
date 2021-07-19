import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(StakeState state, Dispatch dispatch, ViewService viewService) {
  var context = viewService.context;

  return Scaffold(
    body: Container(
      constraints: BoxConstraints.expand(),
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        color: ColorsTheme.of(context).primaryBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              key: Key('backButton'),
              child: Icon(Icons.arrow_back_ios),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Text(
                  FlutterI18n.translate(context, 'stake_earn_mxc'),
                  style: FontTheme.of(context).big(),
                ),
              ),
              Link(
                FlutterI18n.translate(context, 'learn_more'),
                onTap: () => Tools.launchURL(Sys.stakeMore),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 5),
                style: FontTheme.of(context).middle.mxc.underline(),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(context, 'staking_trade_tip'),
            style: FontTheme.of(context).middle.secondary(),
          ),
          Text(
            FlutterI18n.translate(context, 'choose_stake_options'),
            style: FontTheme.of(context).middle.secondary(),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(FlutterI18n.translate(context, 'mxc_vault'),
                  style: FontTheme.of(context).big()),
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
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _stakeCard(
                  key: ValueKey('stake24'),
                  context: context,
                  dispatch: dispatch,
                  months: 24,
                  color: ColorsTheme.of(context).mxcBlue,
                  boostText: state.rate24m == null
                      ? null
                      : '+${round(state.rate24m / state.rate12m)}% ' +
                          FlutterI18n.translate(context, 'mega_boost'),
                  first: true,
                  state: state,
                  revenueRate: state.rate24m,
                  marketingBoost: state.rate24m == null
                      ? null
                      : round(state.rate24m / state.rate12m),
                ),
                _stakeCard(
                  key: ValueKey('stake12'),
                  context: context,
                  months: 12,
                  color: ColorsTheme.of(context).mxcBlue80,
                  boostText: FlutterI18n.translate(context, 'standard_boost'),
                  state: state,
                  revenueRate: state.rate12m,
                  marketingBoost: 0,
                ),
                _stakeCard(
                  key: ValueKey('stake9'),
                  context: context,
                  months: 9,
                  color: ColorsTheme.of(context).mxcBlue60,
                  boostText: state.rate9m == null
                      ? null
                      : '${round(state.rate9m / state.rate12m)}% ' +
                          FlutterI18n.translate(context, 'boost'),
                  state: state,
                  revenueRate: state.rate9m,
                  marketingBoost: state.rate9m == null
                      ? null
                      : round(state.rate9m / state.rate12m),
                ),
                _stakeCard(
                  key: ValueKey('stake6'),
                  context: context,
                  months: 6,
                  color: ColorsTheme.of(context).mxcBlue40,
                  boostText: state.rate6m == null
                      ? null
                      : '${round(state.rate6m / state.rate12m)}% ' +
                          FlutterI18n.translate(context, 'boost'),
                  state: state,
                  revenueRate: state.rate6m,
                  marketingBoost: state.rate6m == null
                      ? null
                      : round(state.rate6m / state.rate12m),
                ),
                _stakeCard(
                  key: ValueKey('stakeFlex'),
                  context: context,
                  color: ColorsTheme.of(context).mxcBlue20,
                  boostText: state.rateFlex == null
                      ? null
                      : '${round(state.rateFlex / state.rate12m)}% ' +
                          FlutterI18n.translate(context, 'boost'),
                  state: state,
                  revenueRate: state.rateFlex,
                  stakeName: FlutterI18n.translate(context, 'flex_stake'),
                  marketingBoost: state.rateFlex == null
                      ? null
                      : round(state.rateFlex / state.rate12m),
                ),
              ],
            ),
          )
        ],
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
                FlutterI18n.translate(context, 'info_mxc_vault'),
                style: TextStyle(
                  color: ColorsTheme.of(context).textPrimaryAndIcons,
                  fontSize: s(16),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    ),
  );
}

int round(double v) {
  return ((v * 100) - 100).round();
}

Widget _stakeCard({
  BuildContext context,
  int months,
  Color color,
  String boostText,
  double revenueRate,
  bool first = false,
  String stakeName,
  StakeState state,
  int marketingBoost,
  Dispatch dispatch,
  Key key,
}) {
  return PanelFrame(
    rowTop: first ? EdgeInsets.only(top: 10) : null,
    child: ListTile(
      key: key,
      onTap: () async {
        if (revenueRate == null) return;
        dynamic data = await Navigator.of(context)
            .pushNamed('prepare_stake_page', arguments: {
          'isDemo': state.isDemo,
          'balance': state.balance,
          'months': months,
          'revenueRate': revenueRate,
          'iconColor': color,
          'stakeName': stakeName,
          'rateFlex': state.rateFlex,
          'marketingBoost': marketingBoost,
        });

        if (data['balance'] != null) {
          dispatch(StakeActionCreator.balance(data['balance']));
        }

        if (data['result'] ?? false) {
          Navigator.of(context).pop(true);
        }
      },
      leading: Container(
        height: 44,
        width: 44,
        alignment: Alignment.center,
        child: Text(
          months?.toString() ?? '~',
          style: FontTheme.of(context).veryBig.button.bold(),
        ),
        padding: EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
      title: Text(
        stakeName ??
            FlutterI18n.translate(context, 'x_month_stake')
                .replaceFirst('{0}', months.toString()),
      ),
      subtitle: Text(
        boostText == null ? '...' : boostText,
        style: FontTheme.of(context).middle().copyWith(
              color: ColorsTheme.of(context).mxcBlue,
              fontWeight: FontWeight.w600,
            ),
        key: Key('setBoost'),
      ),
    ),
  );
}

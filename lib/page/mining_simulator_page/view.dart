import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';

import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/slider.dart';
import 'package:supernodeapp/common/components/value_listenable.dart';
import 'package:supernodeapp/common/components/wallet/mining_tutorial.dart';
import 'package:supernodeapp/common/utils/dhx.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/page/mining_simulator_page/widgets/action_button.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';
import 'widgets/value_editor.dart';

Widget buildView(
    MiningSimulatorState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return GestureDetector(
    key: Key('miningSimulatorView'),
    onTap: () =>
        FocusScope.of(viewService.context).requestFocus(new FocusNode()),
    child: Form(
      key: state.formKey,
      child: pageFrame(
        context: viewService.context,
        resizeToAvoidBottomInset: true,
        children: [
          pageNavBar(FlutterI18n.translate(_ctx, 'mining_simulator'),
              onTap: () => Navigator.pop(viewService.context)),
          SizedBox(height: 35),
          ValueEditor(
            key: ValueKey('amountValueEditor'),
            controller: state.mxcAmountCtl,
            total: state.mxcTotal,
            title: FlutterI18n.translate(_ctx, 'lock_amount'),
            subtitle: FlutterI18n.translate(_ctx, 'current_balance'),
            textFieldSuffix: 'MXC',
            totalSuffix: 'MXC',
          ),
          SizedBox(height: 35),
          ValueEditor(
            key: ValueKey('minersValueEditor'),
            controller: state.minersAmountCtl,
            total: state.minersTotal,
            title: FlutterI18n.translate(_ctx, 'amount_of_miner'),
            subtitle: FlutterI18n.translate(_ctx, 'amount_of_miner_desc'),
            textFieldSuffix: FlutterI18n.translate(_ctx, 'miner'),
            showSlider: false,
          ),
          SizedBox(height: 35),
          Text(
            FlutterI18n.translate(_ctx, 'mxc_lockdrop_duration'),
            style: kBigFontOfBlack,
          ),
          MxcSliderTheme(
            child: Slider(
              key: ValueKey('monthsSlider'),
              value: monthsOptions.indexOf(state.months).toDouble(),
              max: (monthsOptions.length - 1).toDouble(),
              divisions: (monthsOptions.length - 1),
              activeColor: Color(0xFF4665EA),
              inactiveColor: Color(0xFF4665EA).withOpacity(0.2),
              onChanged: (v) => dispatch(MiningSimulatorActionCreator.months(
                  monthsOptions[v.toInt()])),
            ),
          ),
          Text(
            FlutterI18n.translate(_ctx, 'months_lockdrop_duration')
                .replaceAll('{0}', state.months.toString())
                .replaceAll('{1}', () {
              final boostRate = monthsToBoost(state.months);
              final boostRatePercents = (boostRate * 100).round();
              return boostRatePercents == 0
                  ? FlutterI18n.translate(_ctx, 'no_boost')
                  : FlutterI18n.translate(_ctx, 'x_boost')
                      .replaceAll('{0}', '$boostRatePercents%');
            }()),
            style: kSmallFontOfGrey,
          ),
          SizedBox(height: 35),
          ValueEditor(
            key: ValueKey('fuelValueEditor'),
            controller: state.dhxFuelCtl,
            total: 0.0,
            title: FlutterI18n.translate(_ctx, 'dhx_fuel'),
            subtitle: FlutterI18n.translate(_ctx, 'current_balance'),
            textFieldSuffix: 'DHX',
            totalSuffix: 'DHX',
            hintText: FlutterI18n.translate(_ctx, 'not_activated_yet'),
            enabled: false,
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 90,
                        child: Text(
                          FlutterI18n.translate(_ctx, 'estimated_dhx_daily'),
                          style: kSmallFontOfGrey,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 90,
                        child: Text(
                          FlutterI18n.translate(_ctx, 'estimated_mining_power'),
                          style: kSmallFontOfGrey,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: ValueListenableBuilder2(
                          state.minersAmountCtl, state.mxcAmountCtl, builder:
                              (ctx, TextEditingValue miners,
                                  TextEditingValue mxc, _) {
                        final dailyReturn =
                            getDailyReturn(state, mxc.text, miners.text);
                        final res = dailyReturn == null || dailyReturn.isNaN
                            ? null
                            : Tools.numberRounded(dailyReturn);
                        return Text(
                          (res ?? '??'),
                          key: ValueKey('dailyText'),
                          style: kBigFontOfBlack,
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ValueListenableBuilder2(
                          state.minersAmountCtl, state.mxcAmountCtl, builder:
                              (ctx, TextEditingValue miners,
                                  TextEditingValue mxc, _) {
                        final mPower = getMPower(state, mxc.text, miners.text);
                        final res =
                            mPower == null ? null : Tools.numberRounded(mPower);
                        return Text(
                          (res ?? '??'),
                          key: ValueKey('mPowerText'),
                          style: kBigFontOfBlack,
                        );
                      }),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              if (state.calculateExpandState ==
                  CalculateExpandState.notExpanded)
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: SmallActionButton(
                          key: ValueKey('dailyButton'),
                          text: 'DHX',
                          onTap: () => dispatch(
                              MiningSimulatorActionCreator.expandCalculation(
                                  CalculateExpandState.dhx)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: SmallActionButton(
                          key: ValueKey('mPowerButton'),
                          text: 'mPower',
                          onTap: () => dispatch(
                              MiningSimulatorActionCreator.expandCalculation(
                                  CalculateExpandState.mPower)),
                        ),
                      ),
                    ),
                  ],
                ),
              if (state.calculateExpandState == CalculateExpandState.dhx)
                ValueListenableBuilder2(
                    state.minersAmountCtl, state.mxcAmountCtl, builder: (ctx,
                        TextEditingValue miners, TextEditingValue mxc, _) {
                  final dailyReturn =
                      getDailyReturn(state, mxc.text, miners.text);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: SmallActionButton(
                      key: ValueKey('dailyExpandedButton'),
                      width: double.infinity,
                      text: (dailyReturn == null || dailyReturn.isNaN
                              ? '??'
                              : dailyReturn.toStringAsFixed(0)) +
                          ' DHX',
                      onTap: () => dispatch(
                          MiningSimulatorActionCreator.expandCalculation(
                              CalculateExpandState.notExpanded)),
                    ),
                  );
                }),
              if (state.calculateExpandState == CalculateExpandState.mPower)
                ValueListenableBuilder2(
                    state.minersAmountCtl, state.mxcAmountCtl, builder: (ctx,
                        TextEditingValue miners, TextEditingValue mxc, _) {
                  final mPower = getMPower(state, mxc.text, miners.text);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: SmallActionButton(
                      key: ValueKey('mPowerExpandedButton'),
                      width: double.infinity,
                      text: (mPower == null || mPower.isNaN
                              ? '??'
                              : mPower.toStringAsFixed(0)) +
                          ' mPower',
                      onTap: () => dispatch(
                          MiningSimulatorActionCreator.expandCalculation(
                              CalculateExpandState.notExpanded)),
                    ),
                  );
                }),
            ],
          ),
          SizedBox(height: 35),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: ActionButton(
                    text: FlutterI18n.translate(_ctx, 'back'),
                    onTap: () => Navigator.of(_ctx).pop(),
                    primary: false,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: ActionButton(
                    text: FlutterI18n.translate(_ctx, 'mine_dhx'),
                    onTap: () {
                      Navigator.of(_ctx).pushNamed('lock_page', arguments: {
                        'balance': state.mxcTotal,
                        'isDemo': state.isDemo,
                      });
                      Navigator.push(_ctx, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return Scaffold(
                            appBar: AppBars.backArrowSkipAppBar(
                                onPress: () => Navigator.pop(context),
                                action: FlutterI18n.translate(context, "skip")),
                            body: MiningTutorial(context),
                          );
                        },
                      ));
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    ),
  );
}

double getDailyReturn(
    MiningSimulatorState state, String mxcText, String minersText) {
  final mxcValue = double.tryParse(mxcText);
  final minersCount = int.tryParse(minersText);
  return calculateDhxDaily(
    dhxTotal: state.dhxTotal,
    minersCount: minersCount,
    months: state.months,
    mxcValue: mxcValue,
    yesterdayMining: state.yesterdayMining,
  );
}

double getMPower(
    MiningSimulatorState state, String mxcText, String minersText) {
  final mxcValue = double.tryParse(mxcText);
  final minersCount = int.tryParse(minersText);
  return mxcValue == null || minersCount == null
      ? null
      : calculateMiningPower(
          mxcValue, minersCount, monthsToBoost(state.months));
}
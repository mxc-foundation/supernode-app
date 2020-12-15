import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/security/biometrics.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ConfirmLockState state, Dispatch dispatch, ViewService viewService) {
  final context = viewService.context;

  return GestureDetector(
    key: Key('confirmLockPageView'),
    onTap: () =>
        FocusScope.of(viewService.context).requestFocus(new FocusNode()),
    child: pageFrame(
      context: viewService.context,
      scaffoldKey: state.scaffoldKey,
      children: [
        pageNavBar(
          FlutterI18n.translate(context, 'dhx_mining'),
          onTap: () => Navigator.of(context).pop(),
        ),
        SizedBox(height: 35),
        SizedBox(
          width: double.infinity,
          child: Text(
            FlutterI18n.translate(context, 'mining'),
            style: kPrimaryBigFontOfBlack,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          child: Text(
            FlutterI18n.translate(context, 'mining_confirm_tip')
                .replaceAll('{0}', state.months.toString()),
            style: kMiddleFontOfGrey,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'mining_start_date')),
            Expanded(
              child: Text(
                Tools.dateFormat(state.startDate),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'mining_end_date')),
            Expanded(
              child: Text(
                Tools.dateFormat(state.endDate),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'amount')),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, '${state.amount} MXC'),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(),
        SizedBox(height: 10),
        Text(
          FlutterI18n.translate(context, 'mining_boost'),
          style: kPrimaryBigFontOfBlack,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'mining_duration')),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, 'x_months')
                    .replaceAll('{0}', state.months.toString()),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, 'TODO %'),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'miner_owner')),
            Expanded(
              child: Text(
                state.minersOwned.toString(),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, 'TODO %'),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'council')),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, state.councilName),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 35),
        Row(
          children: [
            Text(
              FlutterI18n.translate(context, 'potential_m_power'),
              style: kBigFontOfBlack,
            ),
            SizedBox(width: 30),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Color(0x4665EA).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                child: Text(
                  '${state.miningPower.toStringAsFixed(0)} Mil mPower',
                  style: kMiddleFontOfBlack,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              FlutterI18n.translate(context, 'avg_dhx_daily_revenue'),
              style: kBigFontOfBlack,
            ),
            SizedBox(width: 30),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Color(0x4665EA).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                child: Text(
                  FlutterI18n.translate(context, 'coming'),
                  style: kMiddleFontOfGrey,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        submitButton(
          FlutterI18n.translate(context, 'proceed'),
          onPressed: () => _proceed(dispatch, state),
          key: ValueKey('submitButton'),
        )
      ],
    ),
  );
}

_proceed(Dispatch dispatch, ConfirmLockState state) {
  showCupertinoModalPopup(
    context: state.scaffoldKey.currentState.context,
    builder: (ctx) => CupertinoActionSheet(
      message: Column(
        children: [
          Text(
            FlutterI18n.translate(ctx, 'dhx_mining'),
            style: kBigFontOfBlue,
          ),
          SizedBox(height: 16),
          Text(
            FlutterI18n.translate(ctx, 'lock_confirm_message')
                .replaceAll('{0}', state.amount)
                .replaceAll('{1}', state.months.toString())
                .replaceAll('{2}', state.council.name),
            style: kMiddleFontOfBlack,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
        ],
      ),
      actions: [
        StreamBuilder<Duration>(
          stream:
              UiUtils.timeLeftStream(state.openTime.add(Duration(seconds: 30))),
          builder: (_, snap) {
            if (snap.data == null) return Container();
            final dur = snap.data;
            if (dur.isNegative) {
              return CupertinoActionSheetAction(
                child: Text(FlutterI18n.translate(ctx, 'proceed_anyway')),
                onPressed: () async {
                  final authenticated = await Biometrics.authenticateAsync(ctx);
                  if (!authenticated) return;
                  dispatch(ConfirmLockActionCreator.onConfirm());
                },
                key: ValueKey('submitButton'),
              );
            }
            return CupertinoActionSheetAction(
              child: Text(FlutterI18n.translate(ctx, 'proceed_anyway') +
                  ' (${dur.inSeconds})'),
              key: ValueKey('submitButtonTimeout'),
              onPressed: () {},
            );
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          FlutterI18n.translate(ctx, 'got_it'),
          style: kBigFontOfGrey,
        ),
        onPressed: () => Navigator.of(ctx).pop(),
      ),
    ),
  );
}
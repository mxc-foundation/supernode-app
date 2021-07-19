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
import 'package:supernodeapp/theme/theme.dart';

import 'state.dart';

Widget buildView(
    ConfirmStakeState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(
    context: viewService.context,
    children: [
      pageNavBar(FlutterI18n.translate(_ctx, 'stake'),
          onTap: () => Navigator.pop(viewService.context)),
      SizedBox(height: 30),
      Center(
        child: Text(
          FlutterI18n.translate(_ctx, 'stake'),
          style: FontTheme.of(_ctx).veryBig(),
        ),
      ),
      SizedBox(height: 20),
      Center(
        child: Text(
          FlutterI18n.translate(_ctx, 'stake_warning'),
          style: FontTheme.of(_ctx).middle().copyWith(
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(height: 60),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'stake_date') + ' :'),
              Text(formatDate(DateTime.now())),
            ],
          ),
          if (state.endDate != null) ...[
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(FlutterI18n.translate(_ctx, 'end_date') + ' :'),
                Text(formatDate(state.endDate)),
              ],
            ),
          ],
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'amount') + ' :'),
              Text(state.amount.toString()),
            ],
          ),
        ],
      ),
      SizedBox(height: 20),
      StreamBuilder<Duration>(
        stream:
            UiUtils.timeLeftStream(state.openTime.add(Duration(seconds: 30))),
        builder: (ctx, snap) {
          if (snap.data == null) return Container();
          final dur = snap.data;
          if (dur.isNegative) {
            return submitButton(
              FlutterI18n.translate(ctx, 'proceed_anyway'),
              onPressed: () async {
                final authenticated = await Biometrics.authenticateAsync(ctx);
                if (!authenticated) return;
                Navigator.of(_ctx).pop(true);
              },
              color: ColorsTheme.of(_ctx).mxcBlue,
              key: ValueKey('submitButton'),
            );
          }
          return submitButton(
            FlutterI18n.translate(_ctx, 'proceed_anyway') +
                ' (${dur.inSeconds})',
            key: ValueKey('submitButtonTimeout'),
            color: ColorsTheme.of(_ctx).mxcBlue,
            onPressed: null,
          );
        },
      ),
      submitButton(
        FlutterI18n.translate(_ctx, 'go_back'),
        top: 16,
        onPressed: () {
          Navigator.of(_ctx).pop();
        },
        color: ColorsTheme.of(_ctx).mxcBlue,
        key: ValueKey('goBackButton'),
      ),
    ],
  );
}

String formatDate(DateTime date) {
  return Tools.dateFormat(date);
}

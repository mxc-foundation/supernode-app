import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/stake_page/details_stake_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    DetailsStakeState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  final months = state.stake.months;
  Color iconColor;

  switch (months) {
    case 24:
      iconColor = stake24Color;
      break;
    case 12:
      iconColor = stake12Color;
      break;
    case 9:
      iconColor = stake9Color;
      break;
    case 6:
      iconColor = stake6Color;
      break;
    default:
      iconColor = stakeFlexColor;
      break;
  }
  if (months == 12) {
    iconColor = stake12Color;
  }

  return pageFrame(
    context: viewService.context,
    children: [
      pageNavBar(FlutterI18n.translate(_ctx, 'stake'),
          onTap: () => Navigator.pop(viewService.context)),
      SizedBox(height: 30),
      Row(
        children: [
          Container(
            height: 44,
            width: 44,
            alignment: Alignment.center,
            child: Text(
              months == null ? '~' : months.toString(),
              style: Theme.of(_ctx).textTheme.bodyText1.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            padding: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor,
            ),
          ),
          SizedBox(width: 16),
          months == null
              ? Row(
            children: [
              Text(
                FlutterI18n.translate(_ctx, 'flex_stake'),
                style: kBigFontOfBlack.copyWith(fontWeight: FontWeight.w600)
              ),
              GestureDetector(
                onTap: () => _showInfoDialog(_ctx),
                child: Padding(
                  key: Key("questionCircle"),
                  padding: EdgeInsets.all(s(5)),
                  child: Image.asset(AppImages.questionCircle, height: s(20)),
                ),
              )
            ],
          )
              : Text(FlutterI18n.translate(_ctx, 'x_month_stake').replaceFirst('{0}', months.toString()),
            style: kBigFontOfBlack.copyWith(fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Text('MXC/ETH'),
        ],
      ),
      SizedBox(height: 30),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, "transaction_id") + ' :'),
              Text(
                state.stake.id.toString(),
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'stake_date') + ' :'),
              Text(
                formatDate(state.stake.startTime),
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'end_date') + ' :'),
              Text(
                state.stake.lockTill == null
                    ? '-'
                    : formatDate(state.stake.lockTill),
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'unstake_date') + ' :'),
              Text(
                state.stake.endTime == null
                    ? '-'
                    : formatDate(state.stake.endTime),
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'amount') + ' :'),
              Text(
                state.stake.amount.toString() + ' MXC',
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'revenue') + ' :'),
              Text(
                state.stake.revenue.toString() + ' MXC',
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              (double.parse(state.stake.amount) + state.stake.revenue)
                      .toStringAsFixed(2) +
                  ' MXC',
              style: kBigFontOfBlack.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          if (state.stake.endTime != null) ...[
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                FlutterI18n.translate(_ctx, 'unstaked'),
                style: kBigFontOfGrey,
              ),
            ),
          ]
        ],
      ),
      SizedBox(height: 40),
      if (state.stake.endTime == null)
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            onTap: (state.stake.lockTill == null ||
                    state.stake.lockTill.isBefore(DateTime.now()))
                ? () {
                    dispatch(DetailsStakeActionCreator.unstake());
                  }
                : null,
            buttonTitle: submitText(_ctx, state),
            key: ValueKey('primaryButton'),
          ),
        ),
    ],
  );
}

void _showInfoDialog(BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FullScreenDialog(
        child: IosStyleBottomDialog2(
            context: context,
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  alignment: Alignment.center,
                  child: Text('~',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: stakeFlexColor,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      FlutterI18n.translate(context, 'info_flex_stake'),
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

String formatDate(DateTime date) {
  return Tools.dateFormat(date);
}

String submitText(BuildContext ctx, DetailsStakeState state) {
  if (state.otpEnabled) return FlutterI18n.translate(ctx, 'unstake');
  return FlutterI18n.translate(ctx, 'unstake') +
      ' (' +
      FlutterI18n.translate(ctx, 'required_2FA_general') +
      ')';
}

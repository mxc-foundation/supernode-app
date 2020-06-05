import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/introduction.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/page/subtitle.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/configs/sys.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/tools.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(StakeState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(
    context: viewService.context,
    children: [
      pageNavBar(
        FlutterI18n.translate(_ctx, state.type),
        onTap: () => Navigator.pop(viewService.context,state.resSuccess)
      ),
      introduction(FlutterI18n.translate(_ctx, 'staking_trade_tip')),
      link(
        FlutterI18n.translate(_ctx, 'learn_more'),
        onTap: () => Tools.launchURL(Sys.stakeMore),
        alignment: Alignment.centerLeft
      ),
      Form(
        key: state.formKey,
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          child: TextFieldWithTitle(
            title: FlutterI18n.translate(_ctx, state.type == 'stake' ? 'stake_amount' : 'unstake_amount'),
            validator: (value) => Reg.onValidAmount(_ctx, value),
            controller: state.amountCtl,
          ),
        ),
      ),
      Visibility(
        visible: state.type == 'stake',
        child: subtitle(
          FlutterI18n.translate(_ctx, 'revenue_rate')
        ),
      ),
      Visibility(
        visible: state.type == 'stake',
        child: paragraph(
         '1% ${FlutterI18n.translate(_ctx, "monthly")}'
        ),
      ),
      submitButton(
        FlutterI18n.translate(_ctx, state.type == 'stake' ? 'confirm_stake' : 'confirm_unstake'),
        onPressed: () => dispatch(StakeActionCreator.onConfirm())
      )
    ]
  );
}

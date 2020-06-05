import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/page/subtitle.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_button.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'package:supernodeapp/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(WithdrawState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(
    context: viewService.context,
    children: [
      pageNavBar(
        FlutterI18n.translate(_ctx, 'withdraw'),
        onTap: () => Navigator.pop(viewService.context,state.status)
      ),
      subtitle(FlutterI18n.translate(_ctx, 'current_balance')),
      paragraph('${Tools.priceFormat(state.balance)} MXC'),
      Form(
        // autovalidate: true,
        key: state.formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: TextFieldWithTitle(
                title: FlutterI18n.translate(_ctx, 'withdraw_amount'),
                textInputAction: TextInputAction.next,
                validator: (value) => _onValidAmount(_ctx,value),
                controller: state.amountCtl,
              ),
            ),
            smallColumnSpacer(),
            textfieldWithButton(
              //readOnly: true,
              inputLabel: FlutterI18n.translate(_ctx, 'to'),
              buttonLabel: FlutterI18n.translate(_ctx, 'qr_scan'),
              icon: Icons.center_focus_weak,
              // validator: _onValidAddress,
              controller: state.addressCtl,
              onTap: () => dispatch(WithdrawActionCreator.onQrScan())
            ),
          ]
        ),
      ),
      subtitle(FlutterI18n.translate(_ctx, 'current_transaction_fee')),
      paragraph('${state.fee} MXC'),
      Container(
        child: Text(
            FlutterI18n.translate(_ctx,'wthdr_ent_code_01'),
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
              fontSize: 12,
            )
        ),
      ),
      state.isEnabled?
      submitButton(
          FlutterI18n.translate(_ctx, 'submit_request'),
          onPressed: () => dispatch(WithdrawActionCreator.onEnterSecurityWithdrawContinue())
      ):submitButton(
          'Required 2FA for withdrawal',
          onPressed: () => dispatch(WithdrawActionCreator.onGotoSet2FA())
      ),
    ]
  );
}

String _onValidAmount(BuildContext context,String value){
  String res = Reg.isEmpty(value);
  if(res != null) return FlutterI18n.translate(context, res); 

  RegExp emailRule = new RegExp(r'^[1-9]\d*$');

  if(!emailRule.hasMatch(value.trim())){
    return FlutterI18n.translate(context, 'reg_amount');
  }

  return null;
}

String _onValidAddress(BuildContext context,String value){
  String res = Reg.isEmpty(value);
  if(res != null) return FlutterI18n.translate(context, res); 

  return null;
}
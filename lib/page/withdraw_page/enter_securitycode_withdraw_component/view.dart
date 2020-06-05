
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/utils/reg.dart';

import '../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(EnterSecurityCodeWithdrawState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  state.isEnabled = true;
  return pageFrame(
      context: viewService.context,
      children: [
        pageNavBar(
            FlutterI18n.translate(_ctx, 'withdraw'),
            onTap: () => Navigator.pop(viewService.context)
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          alignment: FractionalOffset(0.5, 0.5),
          child: Column(

              children: <Widget>[
                Text(
                    FlutterI18n.translate(_ctx,'wthdr_ent_code_01'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    )
                ),
              ]
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          alignment: FractionalOffset(0.5, 0.5),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                    FlutterI18n.translate(_ctx,'wthdr_ent_code_02'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    )
                ),
              ]
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 80.0),
          alignment: FractionalOffset(0.5, 0.5),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                    FlutterI18n.translate(_ctx,'wthdr_ent_code_03'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    )
                ),
              ]
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 0, left: 40,right: 40),
          child: TextFieldWithTitle(
            title: FlutterI18n.translate(_ctx,'wthdr_ent_code_04'),
            textInputAction: TextInputAction.next,
            controller: state.otpCodeCtl,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 280.0, 0.0, 00.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                PrimaryButton(
                    onTap: () => dispatch(WithdrawActionCreator.onSubmit()),
                    buttonTitle: FlutterI18n.translate(_ctx, 'confirm'),
                    minHeight: 46
                ),
              ]
          ),
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
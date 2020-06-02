import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_codes.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(EnterSecurityCodeState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
print('enter security');
  print(state.isEnabled);
  return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cardBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          child: Container(
              padding: kRoundRow202,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //paragraph(FlutterI18n.translate(_ctx, 'send_email')),
                  paragraph(FlutterI18n.translate(_ctx,'enter_security_01')),
                  Form(
                    key: state.formKey,
                    autovalidate: false,
                    child: Column(
                        children: <Widget>[
                          Container(
                            margin: kOuterRowTop35,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: state.listCtls.asMap().keys.map((index) => textfieldWithCodes(
                                    context: _ctx,
                                    controller: state.listCtls[index],
                                    isLast: index == state.listCtls.length - 1
                                )).toList()
                            ),
                          ),
                        ]
                    ),
                  ),
                  Spacer(),
                  state.isEnabled ?
                  PrimaryButton(
                      onTap: () => dispatch(Set2FAActionCreator.onSetDisable()),
                      buttonTitle: FlutterI18n.translate(_ctx, 'confirm'),
                      minHeight: 46
                  ):
                  PrimaryButton(
                      onTap: () => dispatch(Set2FAActionCreator.onSetEnable()),
                      buttonTitle: FlutterI18n.translate(_ctx, 'confirm'),
                      minHeight: 46
                  ),
                ],
              )
          )
      )
  );
}

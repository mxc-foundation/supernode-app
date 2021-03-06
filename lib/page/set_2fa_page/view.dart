import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar_back.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    Set2FAState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(context: viewService.context, children: [
    pageNavBarBack(_ctx, FlutterI18n.translate(_ctx, 'set_fa_01'),
        onTap: () => Navigator.of(viewService.context).pop()),
    Form(
        key: state.formKey,
        child: Column(children: <Widget>[
          bigColumnSpacer(),
          Container(
            margin: kRoundRow5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  FlutterI18n.translate(_ctx, 'set_fa_02'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: state.isEnabled ?? false,
                  onChanged: state.isEnabled == null
                      ? null
                      : (value) {
                          if (value) {
                            dispatch(Set2FAActionCreator.onGetTOTPConfig(240));
                          } else {
                            dispatch(
                                Set2FAActionCreator.onEnterRecoveryContinue());
                          }
                        },
                  activeColor: ColorsTheme.of(_ctx).mxcBlue,
                ),
              ],
            ),
          ),
          smallColumnSpacer(),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                /*Container(
                    child: state.isEnabled ?
                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: state.regenerate,
                            onChanged: (value) {
                              dispatch(Set2FAActionCreator.isRegenerate(value));
                            }
                        ),
                        Text('Regenerate recovery code')
                      ],
                    ) :Text(""),
                  ),*/
                middleColumnSpacer(),
              ],
            ),
          ),
        ])),
  ]);
}

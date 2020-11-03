import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/page/subtitle.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_button.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    WithdrawState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(context: viewService.context, children: [
    pageNavBar(FlutterI18n.translate(_ctx, 'withdraw'),
        onTap: () => Navigator.pop(viewService.context, state.status)),
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
              validator: (value) =>
                  _onValidAmount(_ctx, value, state.fee, state.balance),
              controller: state.amountCtl,
            ),
          ),
          smallColumnSpacer(),
          textfieldWithButton(
            //readOnly: true,
            inputLabel: FlutterI18n.translate(_ctx, 'to'),
            buttonLabel: FlutterI18n.translate(_ctx, 'qr_scan'),
            suffixTitleChild: GestureDetector(
              key: ValueKey('addressBookButton'),
              onTap: () => dispatch(WithdrawActionCreator.onAddressBook()),
              child: Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  FlutterI18n.translate(_ctx, 'address_book'),
                  style: kMiddleFontOfBlack.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            icon: Icons.center_focus_weak,
            // validator: _onValidAddress,
            controller: state.addressCtl,
            onTap: () => dispatch(WithdrawActionCreator.onQrScan()),
          ),
        ],
      ),
    ),
    Row(
      children: [
        subtitle(FlutterI18n.translate(_ctx, 'current_transaction_fee')),
        GestureDetector(
          onTap: () => _showInfoDialog(_ctx),
          child: Padding(
            key: Key("questionCircle"),
            padding: EdgeInsets.only(top: 30+s(5), bottom: s(5), left: s(5), right: s(5)),
            child: Image.asset(AppImages.questionCircle, height: s(20)),
          ),
        )
      ],
    ),
    paragraph('${state.fee ?? '--'} MXC'),
    SizedBox(height: 40),
    Container(
      child: Text(
        FlutterI18n.translate(_ctx, '24hours_warning'),
        style: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    ),
    submitButton(
      FlutterI18n.translate(_ctx, 'submit_request'),
      onPressed: () => dispatch(WithdrawActionCreator.goToConfirmation()),
      key: ValueKey('preconfirmationButton'),
    ),
  ]);
}

String _onValidAmount(
    BuildContext context, String value, double fee, double balance) {
  String res = Reg.isEmpty(value);
  if (res != null) return FlutterI18n.translate(context, res);

  final amount = int.tryParse(value);

  if (amount == null || amount <= 0) {
    return FlutterI18n.translate(context, 'reg_amount');
  }

  if (amount + fee > balance) {
    return FlutterI18n.translate(context, 'insufficient_balance');
  }

  return null;
}

void _showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FullScreenDialog(
        child: IosStyleBottomDialog2(
            context: context,
            child: Column(
              children: [
                Image.asset(AppImages.infoCurrentTransactionFee, height: s(80)),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      FlutterI18n.translate(context, 'info_current_transaction_fee'),
                      key: ValueKey('helpText'),
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
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/page/sign_up_page/registration_component/state.dart';

class EnterSecurityCodeWithdrawState implements Cloneable<EnterSecurityCodeWithdrawState> {

  GlobalKey formKey = GlobalKey<FormState>();
  bool isEnabled;
  TextEditingController otpCodeCtl = TextEditingController();

  @override
  EnterSecurityCodeWithdrawState clone() {
    return EnterSecurityCodeWithdrawState()
      ..formKey = formKey
      ..isEnabled = isEnabled
      ..otpCodeCtl = otpCodeCtl;
  }
}

EnterSecurityCodeWithdrawState initState(Map<String, dynamic> args) {
  return EnterSecurityCodeWithdrawState();
}

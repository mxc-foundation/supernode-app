import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/page/sign_up_page/registration_component/state.dart';

class EnterSecurityCodeState implements Cloneable<EnterSecurityCodeState> {

  GlobalKey formKey = GlobalKey<FormState>();
  bool isEnabled;
  TextEditingController otpCodeCtl = TextEditingController();

  @override
  EnterSecurityCodeState clone() {
    return EnterSecurityCodeState()
      ..formKey = formKey
      ..isEnabled = isEnabled
      ..otpCodeCtl = otpCodeCtl;
  }
}

EnterSecurityCodeState initState(Map<String, dynamic> args) {
  return EnterSecurityCodeState();
}

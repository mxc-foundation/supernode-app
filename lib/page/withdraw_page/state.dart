import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';
import 'enter_securitycode_withdraw_component/state.dart';

class WithdrawState implements Cloneable<WithdrawState> {

  // why use GlobalKey ? it very expensive !
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController amountCtl = TextEditingController();
  TextEditingController addressCtl = TextEditingController();
  
  bool status = false;
  bool isEnabled = false;
  double balance = 0;
  double fee = 20;
  List<OrganizationsState> organizations = [];

  GlobalKey enterSecurityCodeWithdrawFormKey = GlobalKey<FormState>();
  TextEditingController otpCodeCtl = TextEditingController();

  @override
  WithdrawState clone() {
    return WithdrawState()
      ..status = status
      ..balance = balance
      ..fee = fee
      ..isEnabled = isEnabled
      ..organizations = organizations;
  }
}

WithdrawState initState(Map<String, dynamic> args) {
  double balance = args['balance'];
  List<OrganizationsState> organizations = args['organizations'];

  return WithdrawState()
    ..balance = balance
    ..organizations = organizations;
}

class EnterSecurityCodeWithdrawConnector extends ConnOp<WithdrawState, EnterSecurityCodeWithdrawState>{

  @override
  EnterSecurityCodeWithdrawState get(WithdrawState state){
    return EnterSecurityCodeWithdrawState()
      ..formKey = state.enterSecurityCodeWithdrawFormKey
      ..otpCodeCtl = state.otpCodeCtl;
  }

  @override
  void set(WithdrawState state, EnterSecurityCodeWithdrawState subState) {
    state
      ..otpCodeCtl = subState.otpCodeCtl;
  }
}
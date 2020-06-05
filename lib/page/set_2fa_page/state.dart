import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'enter_securitycode_component/state.dart';
import 'recovery_code_component/state.dart';
import 'qr_code_component/state.dart';

class Set2FAState implements Cloneable<Set2FAState> {

  GlobalKey formKey = GlobalKey<FormState>();
  GlobalKey codesFormKey = GlobalKey<FormState>();
  GlobalKey qrCodeFormKey = GlobalKey<FormState>();
  //TextEditingController oldPwdCtl = TextEditingController();

  bool isEnabled = true;
  bool regenerate = false;
  bool isAgreed = false;
  String url = '';
  String secret = '';
  List<dynamic> recoveryCode = [];
  String title = '';
  String qrCode = '';


  GlobalKey enterSecurityCodeFormKey = GlobalKey<FormState>();
  TextEditingController otpCodeCtl = TextEditingController();

  GlobalKey recoveryCodeFormKey = GlobalKey<FormState>();

  @override
  Set2FAState clone() {
    return Set2FAState()
      ..formKey = formKey
      ..url = url
      ..secret = secret
      ..recoveryCode = recoveryCode
      ..title = title
      ..qrCode = qrCode
      ..otpCodeCtl = otpCodeCtl
      ..regenerate = regenerate
      ..isAgreed = isAgreed
      ..isEnabled = isEnabled;
  }
}

Set2FAState initState(Map<String, dynamic> args) {
  bool isEnabled = args['isEnabled'];
  return Set2FAState()
    ..isEnabled = isEnabled;
}

class EnterSecurityCodeConnector extends ConnOp<Set2FAState, EnterSecurityCodeState>{

  @override
  EnterSecurityCodeState get(Set2FAState state){
    return EnterSecurityCodeState()
      ..formKey = state.enterSecurityCodeFormKey
      ..isEnabled = state.isEnabled
      ..otpCodeCtl = state.otpCodeCtl;
  }

  @override
  void set(Set2FAState state, EnterSecurityCodeState subState) {
    state
      ..otpCodeCtl = subState.otpCodeCtl;
  }
}

class RecoveryCodeConnector extends ConnOp<Set2FAState, RecoveryCodeState>{

  @override
  RecoveryCodeState get(Set2FAState state){
    return RecoveryCodeState()
      ..formKey = state.recoveryCodeFormKey
      ..isAgreed = state.isAgreed
      ..recoveryCode = state.recoveryCode;
  }

  @override
  void set(Set2FAState state, RecoveryCodeState subState) {
    state
      ..isAgreed = subState.isAgreed
      ..recoveryCode = subState.recoveryCode;
  }
}

class QRCodeConnector extends ConnOp<Set2FAState, QRCodeState>{

  @override
  QRCodeState get(Set2FAState state){
    return QRCodeState()
      ..formKey = state.qrCodeFormKey
      ..isEnabled = state.isEnabled
      ..url = state.url
      ..secret = state.secret
      ..recoveryCode = state.recoveryCode
      ..title = state.title
      ..qrCode = state.qrCode;
  }

  @override
  void set(Set2FAState state, QRCodeState subState) {
    state
      ..url = subState.url
      ..isEnabled = subState.isEnabled
      ..secret = subState.secret
      ..recoveryCode = subState.recoveryCode
      ..title = subState.title
      ..qrCode = subState.qrCode;
  }
}
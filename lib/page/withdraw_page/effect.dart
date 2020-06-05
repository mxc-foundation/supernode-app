import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:majascan/majascan.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/security/biometrics.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';
import 'package:supernodeapp/common/daos/withdraw_dao.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'action.dart';
import 'state.dart';

Effect<WithdrawState> buildEffect() {
  return combineEffects(<Object, Effect<WithdrawState>>{
    Lifecycle.initState: _initState,
    WithdrawAction.onQrScan: _onQrScan,
    WithdrawAction.onEnterSecurityWithdrawContinue: _onEnterSecurityWithdrawContinue,
    WithdrawAction.onGotoSet2FA: _onGotoSet2FA,
    WithdrawAction.onSubmit: _onSubmit,
  });
}

void _initState(Action action, Context<WithdrawState> ctx) {
  _withdrawFee(ctx);
  _requestTOTPStatus(ctx);
}

void _requestTOTPStatus(Context<WithdrawState> ctx){
 UserDao dao = UserDao();

  Map data = {};

  dao.getTOTPStatus(data).then((res){
    log('totp',res);

    if((res as Map).containsKey('enabled')){
      ctx.dispatch(WithdrawActionCreator.isEnabled(res['enabled']));
    }

  }).catchError((err){
    tip(ctx.context,'$err');
  });
}

void _withdrawFee(Context<WithdrawState> ctx) {
  WithdrawDao dao = WithdrawDao();
  dao.fee().then((res) {
    log('WithdrawDao fee', res);

    if ((res as Map).containsKey('withdrawFee')) {
      ctx.dispatch(WithdrawActionCreator.fee(Tools.convertDouble(res['withdrawFee'])));
    }
  }).catchError((err) {
    tip(ctx.context, 'WithdrawDao fee: $err');
  });
}

void _onQrScan(Action action, Context<WithdrawState> ctx) async {
  String qrResult = await MajaScan.startScan(
      title: FlutterI18n.translate(ctx.context, 'scan_code'),
      barColor: buttonPrimaryColor,
      titleColor: backgroundColor,
      qRCornerColor: buttonPrimaryColor,
      qRScannerColor: buttonPrimaryColorAccent);
  log('_onQrScan', qrResult);
  ctx.dispatch(WithdrawActionCreator.address(qrResult));
}

void _onEnterSecurityWithdrawContinue(Action action, Context<WithdrawState> ctx) async{
  //showLoading(ctx.context);

  Navigator.push(ctx.context,
    MaterialPageRoute(
        maintainState: false,
        fullscreenDialog: false,
        builder:(context){
          return ctx.buildComponent('enterSecurityCodeWithdraw');
        }
    ),
  );
}

void _onGotoSet2FA(Action action, Context<WithdrawState> ctx) async{
  Navigator.pushNamed(ctx.context, 'set_2fa_page',arguments:{'isEnabled': false}).then((_){
    _requestTOTPStatus(ctx);
  });
  //Navigator.of(viewService.context).pushNamed('set_2fa_page', arguments:{'isEnabled': false})
}

void _onSubmit(Action action, Context<WithdrawState> ctx) async {
  var curState = ctx.state;
  double balance = curState.balance;
  String amount = curState.amountCtl.text;
  String address = curState.addressCtl.text;
  // OrganizationsState org = curState.organizations.first;
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  String codes = curState.otpCodeCtl.text;

  if((curState.formKey.currentState as FormState).validate()){
    if(address.trim().isEmpty){
      tip(ctx.context, 'The field of "To" is required.');
      return;
    }

    final canCheckBiometrics = await Biometrics.canCheckBiometrics();

    if (canCheckBiometrics) {
      Biometrics.authenticate(
        ctx.context,
        authenticateCallback: () {
          WithdrawDao dao = WithdrawDao();
          Map data = {
            "orgId": orgId,
            "amount": int.parse(amount),
            "ethAddress": address,
            "availableBalance": balance,
            "otp_code": codes
          };
    showLoading(ctx.context);
    dao.withdraw(data).then((res){
      hideLoading(ctx.context);
      log('withdraw',res);

      if(res.containsKey('status') && res['status']){
        Navigator.pushNamed(ctx.context, 'confirm_page',arguments:{'title': 'withdraw','content': 'withdraw_submit_tip'});
        _updateBalance(ctx);
        ctx.dispatch(WithdrawActionCreator.status(true));
      }else{
        ctx.dispatch(WithdrawActionCreator.status(false));
        tip(ctx.context,res);
      }
    }).catchError((err){
      hideLoading(ctx.context);
      ctx.dispatch(WithdrawActionCreator.status(false));
      tip(ctx.context,'WithdrawDao withdraw: $err');
    });},
        failAuthenticateCallBack: null,
      );
    }
  }
}

void _updateBalance(Context<WithdrawState> ctx) {
  WalletDao dao = WalletDao();
  var settingsData = GlobalStore.store.getState().settings;
  String userId = settingsData.userId;
  String orgId = settingsData.selectedOrganizationId;

  Map data = {'userId': userId, 'orgId': orgId};

  dao.balance(data).then((res) {
    log('balance', res);

    double balance = Tools.convertDouble(res['balance']);
    ctx.dispatch(WithdrawActionCreator.balance(balance));
  }).catchError((err) {
    tip(ctx.context, 'WalletDao balance: $err');
  });
}

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/topup_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Effect<DepositState> buildEffect() {
  return combineEffects(<Object, Effect<DepositState>>{
    Lifecycle.initState: _initState,
    DepositAction.copy: _copy,
  });
}

void _initState(Action action, Context<DepositState> ctx) {
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
  if(orgId == null || orgId.isEmpty){
    orgId = ctx.state.organizations.first.organizationID;
  }

  TopupDao dao = TopupDao();
  Map data = {
    "orgId": orgId
  };

  dao.account(data).then((res) {
    log('account',res);
    
    if((res as Map).containsKey('activeAccount')){
      ctx.dispatch(DepositActionCreator.address(res['activeAccount']));
    }
  }).catchError((err){
    tip(ctx.context,'TopupDao account: $err');
  });
}

void _copy(Action action, Context<DepositState> ctx) {
  var curState = ctx.state;

  Clipboard.setData(ClipboardData(text: curState.address));

  tip(ctx.context,FlutterI18n.translate(ctx.context, 'has_copied'),success: true);
}

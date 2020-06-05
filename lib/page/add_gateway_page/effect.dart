import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:majascan/majascan.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/gateways_dao.dart';
// import 'package:majascan/majascan.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/theme/colors.dart';
// import 'package:qrscan/qrscan.dart' as Scanner;

import 'action.dart';
import 'state.dart';

Effect<AddGatewayState> buildEffect() {
  return combineEffects(<Object, Effect<AddGatewayState>>{
    // Lifecycle.initState: _initState,
    AddGatewayAction.onQrScan: _onQrScan,
    AddGatewayAction.onProfile: _onProfile,
  });
}

// void _initState(Action action, Context<AddGatewayState> ctx) {
//   ctx.dispatch(GatewayProfileActionCreator.initState());
// }

void _onQrScan(Action action, Context<AddGatewayState> ctx) async{
  String qrResult = await MajaScan.startScan(
    title: FlutterI18n.translate(ctx.context, 'scan_code'), 
    barColor: buttonPrimaryColor, 
    titleColor: backgroundColor, 
    qRCornerColor: buttonPrimaryColor,
    qRScannerColor: buttonPrimaryColorAccent
  );
  ctx.dispatch(AddGatewayActionCreator.serialNumber(qrResult));

  try{
    List itemData = qrResult.split(',');
    List snData = itemData[0].split(':');
    String number = snData[1];

    if(Reg.onValidSerialNumber(number)){
      _register(ctx,number);
      return;
    }
  }catch(err){
    tip(ctx.context,'startScan: $err');
  }
  
  Navigator.push(ctx.context,
    MaterialPageRoute(
      maintainState: false,
      fullscreenDialog: true,
      builder:(context){
        return ctx.buildComponent('profile');
      }
    ),
  );
}

void _onProfile(Action action, Context<AddGatewayState> ctx) {
  var curState = ctx.state;

  if((curState.formKey.currentState as FormState).validate()){
    String sn = curState.serialNumberCtl.text;
    if(Reg.onValidSerialNumber(sn)){
      _register(ctx,sn);

      return;
    }

    Navigator.push(ctx.context,
      MaterialPageRoute(
        maintainState: false,
        fullscreenDialog: true,
        builder:(context){
          return ctx.buildComponent('profile');
        }
      ),
    );
  }
}

void _register(Context<AddGatewayState> ctx,String serialNumber){
  
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
  GatewaysDao dao = GatewaysDao();

  Map data = {
    "organizationId": orgId,
    "sn": serialNumber.trim()
  };

  showLoading(ctx.context);
  dao.register(data).then((res){
    hideLoading(ctx.context);
    log('Gateway register',res);

    if(res.containsKey('status')){
      tip(ctx.context,res['status'],success: true);
      if(ctx.state.fromPage == 'home'){
        Navigator.of(ctx.context).pop();
      }
    }
  }).catchError((err){
    hideLoading(ctx.context);
    tip(ctx.context,'Gateway register: $err');
  });
  
}

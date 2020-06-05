import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/security/biometrics.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/stake_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Effect<StakeState> buildEffect() {
  return combineEffects(<Object, Effect<StakeState>>{
    StakeAction.onConfirm: _onConfirm,
  });
}

void _onConfirm(Action action, Context<StakeState> ctx) async {
  // Navigator.pushNamed(ctx.context, 'confirm_page');

  var curState = ctx.state;

  if ((curState.formKey.currentState as FormState).validate()) {
    // List<OrganizationsState> organizationsData = curState.organizations;
    String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
    int amount = int.parse(curState.amountCtl.text);

    Biometrics.authenticate(
      ctx.context,
      authenticateCallback: () {
        StakeDao dao = StakeDao();

        Map data = {"orgId": orgId, "amount": amount};

        void resultPage(String type, dynamic res) {
          if (res.containsKey('status')) {
            Navigator.pushNamed(ctx.context, 'confirm_page',
                arguments: {'title': type, 'content': res['status']});

            ctx.dispatch(StakeActionCreator.resSuccess(res['status'].contains('successful')));
          } else {
            tip(ctx.context, res);
          }
        }

        if (curState.type == 'stake') {
          showLoading(ctx.context);
          dao.stake(data).then((res) async {
            hideLoading(ctx.context);
            log(curState.type, res);
            resultPage('stake', res);
          }).catchError((err) {
            hideLoading(ctx.context);
            tip(ctx.context, 'StakeDao stake: $err');
          });
        } else {
          showLoading(ctx.context);
          dao.unstake(data).then((res) async {
            hideLoading(ctx.context);
            log(curState.type, res);
            resultPage('unstake', res);
          }).catchError((err) {
            hideLoading(ctx.context);
            tip(ctx.context, 'StakeDao stake: $err');
          });
        }
      },
    );
  }
}

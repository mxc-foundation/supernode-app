import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/page/home_page/action.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';
import 'state.dart';

Effect<UserState> buildEffect() {
  return combineEffects(<Object, Effect<UserState>>{
    // Lifecycle.appear: _appear,
    // UserAction.onOperate: _onOperate,
  });
}

void _appear(Action action, Context<UserState> ctx) {
  ctx.dispatch(HomeActionCreator.onProfile());
}

void _onOperate(Action action, Context<UserState> ctx) {
  String act = action.payload;
  String userId = ctx.state.id;
  double balance = ctx.state.balance;
  List<OrganizationsState> organizations = ctx.state.organizations;

  Navigator.pushNamed(ctx.context, '${act}_page',
      arguments: {'balance': balance, 'organizations': organizations, 'userId': userId});
}

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/dhx.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'action.dart';
import 'state.dart';

Effect<ConfirmLockState> buildEffect() {
  return combineEffects(<Object, Effect<ConfirmLockState>>{
    ConfirmLockAction.onConfirm: _onConfirm,
  });
}

DhxDao _buildDhxDao(Context<ConfirmLockState> ctx) =>
    ctx.context.read<SupernodeRepository>().dhx;

void _onConfirm(Action action, Context<ConfirmLockState> ctx) async {
  final council = ctx.state.council;
  final dao = _buildDhxDao(ctx);
  String stakeId;
  try {
    if (council.id == null) {
      final res = await dao.createCouncil(
        amount: ctx.state.amount,
        boost: ctx.state.boostRate.toString(),
        lockMonths: ctx.state.months.toString(),
        name: council.name,
        organizationId: council.chairOrgId,
      );
      stakeId = res.stakeId;
      ctx.dispatch(ConfirmLockActionCreator.setCouncil(
          ctx.state.council.copyWith(id: res.councilId)));
    } else {
      final res = await dao.createStake(
        amount: ctx.state.amount,
        boost: ctx.state.boostRate.toString(),
        councilId: council.id,
        lockMonths: ctx.state.months.toString(),
        organizationId: ctx.context.read<SupernodeCubit>().state.orgId,
      );
      stakeId = res;
    }

    if (stakeId != null) {
      await Navigator.of(ctx.context).pushNamed('result_lock_page',
          arguments: {'isDemo': ctx.state.isDemo, 'stakeId': stakeId});
      Navigator.of(ctx.context).pop(true);
    }
  } catch (err) {
    tip('LockPage: $err');
    print(err);
  }
}

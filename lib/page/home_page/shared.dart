import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/cubit.dart';
import 'package:supernodeapp/page/settings_page/settings_page.dart';
import '../../route.dart';
import 'bloc/supernode/user/cubit.dart';

void openSettings(BuildContext context) async {
  if (context.read<SupernodeUserCubit>().state.organizations.loading) return;
  Navigator.push(context, route((context) => SettingsPage()));
}

Future<void> openSupernodeDeposit(BuildContext context) async {
  final orgId = context.read<SupernodeCubit>().state.orgId;
  final userId = context.read<SupernodeCubit>().state.session.userId;
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'deposit_page',
    arguments: {
      'userId': userId,
      'orgId': orgId,
      'isDemo': isDemo,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
}

Future<void> openSupernodeWithdraw(BuildContext context, Token token) async {
  final balance = context.read<SupernodeUserCubit>().state.balance;
  final balanceBTC = context.read<SupernodeBtcCubit>().state.balance;
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'withdraw_page',
    arguments: {
      'balance': balance.value,
      'balanceBTC': balanceBTC.value,
      'isDemo': isDemo,
      'tokenName': token.name,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
}

Future<void> openSupernodeStake(BuildContext context) async {
  final balance = context.read<SupernodeUserCubit>().state.balance;
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'stake_page',
    arguments: {
      'balance': balance.value,
      'isDemo': isDemo,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
  context.read<SupernodeUserCubit>().refreshStakedAmount();
}

Future<void> openSupernodeUnstake(BuildContext context) async {
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'unstake_page',
    arguments: {
      'isDemo': isDemo,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
  context.read<SupernodeUserCubit>().refreshStakedAmount();
}

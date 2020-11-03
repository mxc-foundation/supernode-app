import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';
import 'package:supernodeapp/common/components/wallet/list_item.dart';
import 'package:supernodeapp/page/home_page/wallet_component/action.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

int i = 0;
Widget buildView(
    GeneralItemState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  if (state is WalletItemState) {
    String followText;
    TextStyle followStyle;
    if (state.amount > 0) {
      followText = '(' + FlutterI18n.translate(_ctx, 'deposit') + ')';
      followStyle = kSmallFontOfGreen;
    }
    if (state.amount < 0) {
      followText = '(' + FlutterI18n.translate(_ctx, 'withdraw') + ')';
      followStyle = kSmallFontOfRed;
    }
    return listItem(
      key: ValueKey('walletItem_${state.id}'),
      context: viewService.context,
      type: state.txType != null ? state.txType : state.type,
      amount: state.amount ?? state.stakeAmount,
      revenue: state.revenue,
      fee: state.fee,
      datetime: state.createdAt ??
          state.txSentTime ??
          state.startStakeTime ??
          state.start ??
          state.timestamp.toIso8601String(),
      secondDateTime: state.unstakeTime ?? state.end,
      fromAddress: state.fromAddress,
      toAddress: state.toAddress,
      txHashAddress: state.txHash,
      followText: followText,
      followStyle: followStyle,
      status: state.txStatus != null
          ? FlutterI18n.translate(_ctx, state.txStatus)
          : FlutterI18n.translate(_ctx, 'completed'),
      isExpand: state.isExpand,
      isLast: state.isLast,
      onTap: () => dispatch(WalletItemActionCreator.isExpand(state)),
    );
  }
  if (state is StakeItemState) {
    if (state.historyEntity.type != 'STAKING') return Container();
    return StakeItem.fromStake(
      state.historyEntity.stake,
      isLast: state.isLast,
      onTap: () => dispatch(
          WalletActionCreator.onStakeDetails(state.historyEntity.stake)),
      key: ValueKey('stakeItem_${state.historyEntity.stake.id}'),
    );
  }
  throw UnimplementedError('Unknown state type ${state.runtimeType}');
}

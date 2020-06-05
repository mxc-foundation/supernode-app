import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/common/utils/tools.dart';

import 'action.dart';
import 'state.dart';
import 'wallet_list_adapter/wallet_item_component/state.dart';

Reducer<WalletState> buildReducer() {
  return asReducer(
    <Object, Reducer<WalletState>>{
      WalletAction.tab: _tab,
      WalletAction.isSetDate: _isSetDate,
      WalletAction.updateSelectedButton: _updateSelectedButton,
      WalletAction.updateList: _updateList,
      WalletAction.withdrawFee: _withdrawFee,
      WalletAction.firstTime: _firstTime,
      WalletAction.secondTime: _secondTime,
    },
  );
}

WalletState _tab(WalletState state, Action action) {
  int tabIndex = action.payload;

  final WalletState newState = state.clone();

  if(state.tabIndex == tabIndex){
    return state;
  }

  return newState
    ..tabIndex = tabIndex
    ..selectedIndexBtn1 = -1
    ..selectedIndexBtn2 = -1
    ..isSetDate1 = false
    ..isSetDate2 = false
    ..tabHeight = tabIndex == 0 ? 100 : 140;
}

WalletState _isSetDate(WalletState state, Action action) {
  final WalletState newState = state.clone();

  if(state.tabIndex == 0 && !state.isSetDate1){
    return newState
      ..selectedIndexBtn1 = 2
      ..isSetDate1 = !state.isSetDate1;
  }else if(state.tabIndex == 1 && !state.isSetDate2){
    return newState
      ..selectedIndexBtn2 = 2
      ..isSetDate2 = !state.isSetDate2;
  }

  return state;
}

WalletState _updateSelectedButton(WalletState state, Action action) {
  int index = action.payload;

  final WalletState newState = state.clone();

  if(state.tabIndex == 0){
    return newState
    ..isSetDate1 = false
    ..isSetDate2 = false
    ..selectedIndexBtn1 = index;
  }

  return newState
    ..isSetDate1 = false
    ..isSetDate2 = false
    ..selectedIndexBtn2 = index;
}

WalletState _updateList(WalletState state, Action action) {
  Map data = action.payload;
  String type = data['type'];
  List<WalletItemState> list = [];
  double totalRevenue = 0;
  for(int index = 0;index < data['list'].length;index ++){
    WalletItemState item = WalletItemState.fromMap(data['list'][index]);

    item.type = type;

    if(type.contains('DEFAULT') || type.contains('DATETIME')) {
      item.type = type.split(' ')[0];
    }

    if(item.revenue != null){
      totalRevenue += item.revenue;
    }
    
    if(type == 'STAKE'){
      if(item.end.contains('--') || (item.end != null && item.end.isEmpty)){
        list.add( item ); 
      }

      continue;
    }

    if(type == 'UNSTAKE'){
      if(item.end != null && item.end.isNotEmpty && !item.end.contains('--')){
        list.add( item ); 
      }

      continue;
    }

    if(type == 'DEPOSIT DATETIME' || type == 'WITHDRAW DATETIME'){
      if(TimeDao.isInRange(item.txSentTime!=null?item.txSentTime:item.createdAt, state.firstTime, state.secondTime)){
        list.add( item );
      }

      continue;
    }
    
    if(type == 'SEARCH' && state.tabIndex == 1 && state.isSetDate2){
      if(TimeDao.isInRange(item.start, state.firstTime, state.secondTime)){
        list.add( item );
      }

      continue;
    }

    list.add( item );
  }
  
  if(type.contains('WITHDRAW DEFAULT') ||type.contains('WITHDRAW DATETIME')) {
    list.addAll(state.list);
  }

  if(list.length > 0) list[list.length - 1].isLast = true;

  final WalletState newState = state.clone();

  return newState 
    ..totalStaking = totalRevenue
    ..list = list;
}

WalletState _withdrawFee(WalletState state, Action action) {
  double fee = action.payload;

  final WalletState newState = state.clone();

  return newState
    ..withdrawFee = fee;
}

WalletState _firstTime(WalletState state, Action action) {
  String date = action.payload;

  final WalletState newState = state.clone();

  return newState
    ..firstTime = date;
}

WalletState _secondTime(WalletState state, Action action) {
  String date = action.payload;

  final WalletState newState = state.clone();

  return newState
    ..secondTime = date;
}
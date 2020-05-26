import 'package:fish_redux/fish_redux.dart';

enum WalletAction { tab, onTab, isSetDate, onFilter, updateSelectedButton, updateList, withdrawFee, firstTime, secondTime }

class WalletActionCreator {
  static Action onTab(int index) {
    return Action(WalletAction.onTab,payload: index);
  }

  static Action tab(int index) {
    return Action(WalletAction.tab,payload: index);
  }

  static Action isSetDate() {
    return const Action(WalletAction.isSetDate);
  }

  static Action onFilter(String type) {
    return Action(WalletAction.onFilter,payload: type);
  }

  static Action updateSelectedButton(int index) {
    return Action(WalletAction.updateSelectedButton,payload: index);
  }

  static Action updateList(String type,List list) {
    return Action(WalletAction.updateList,payload: {"type": type, "list": list});
  }

  static Action withdrawFee(double fee) {
    return Action(WalletAction.withdrawFee,payload: fee);
  }

  static Action firstTime(String date) {
    return Action(WalletAction.firstTime,payload: date);
  }

  static Action secondTime(String date) {
    return Action(WalletAction.secondTime,payload: date);
  }

}
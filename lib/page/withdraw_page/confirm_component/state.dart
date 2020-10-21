import 'package:fish_redux/fish_redux.dart';

class ConfirmState implements Cloneable<ConfirmState> {
  String amount;
  String fee;
  String address;
  DateTime confirmTime;
  bool isEnabled;

  @override
  ConfirmState clone() {
    return ConfirmState()
      ..address = address
      ..amount = amount
      ..confirmTime = confirmTime
      ..fee = fee
      ..isEnabled = isEnabled;
  }
}

ConfirmState initState(Map<String, dynamic> args) {
  return ConfirmState();
}
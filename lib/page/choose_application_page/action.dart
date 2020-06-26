import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChooseApplicationAction { action }

class ChooseApplicationActionCreator {
  static Action onAction() {
    return const Action(ChooseApplicationAction.action);
  }
}

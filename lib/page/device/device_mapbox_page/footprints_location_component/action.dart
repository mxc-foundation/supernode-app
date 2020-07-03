import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FootPrintsLocationAction { action }

class FootPrintsLocationActionCreator {
  static Action onAction() {
    return const Action(FootPrintsLocationAction.action);
  }
}

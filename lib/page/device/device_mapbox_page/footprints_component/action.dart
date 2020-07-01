import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FootprintsAction { action }

class FootprintsActionCreator {
  static Action onAction() {
    return const Action(FootprintsAction.action);
  }
}

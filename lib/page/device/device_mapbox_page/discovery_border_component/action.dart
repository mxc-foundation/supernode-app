import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DiscoveryBorderAction { action }

class DiscoveryBorderActionCreator {
  static Action onAction() {
    return const Action(DiscoveryBorderAction.action);
  }
}

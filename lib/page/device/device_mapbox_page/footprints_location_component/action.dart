import 'package:fish_redux/fish_redux.dart';

enum FootPrintsLocationAction { resetToDefault }

class FootPrintsLocationActionCreator {
  static Action resetToDefault() {
    return const Action(FootPrintsLocationAction.resetToDefault);
  }
}

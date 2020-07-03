import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum BorderPromptAction { action }

class BorderPromptActionCreator {
  static Action onAction() {
    return const Action(BorderPromptAction.action);
  }
}

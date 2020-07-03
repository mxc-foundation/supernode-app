import 'package:fish_redux/fish_redux.dart';

class BorderPromptState implements Cloneable<BorderPromptState> {

  @override
  BorderPromptState clone() {
    return BorderPromptState();
  }
}

BorderPromptState initState(Map<String, dynamic> args) {
  return BorderPromptState();
}

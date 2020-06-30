import 'package:fish_redux/fish_redux.dart';

enum IntroductionAction { changeRadio, changeGenderRadio }

class IntroductionActionCreator {
  static Action onChangeRadio(String value) {
    return Action(IntroductionAction.changeRadio, payload: value);
  }

  static Action onChangeGenderRadio(String value) {
    return Action(IntroductionAction.changeGenderRadio, payload: value);
  }
}

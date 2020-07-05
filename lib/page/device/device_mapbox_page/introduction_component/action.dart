import 'package:fish_redux/fish_redux.dart';

enum IntroductionAction { changeRadio, changeGenderRadio,onAgePicker }

class IntroductionActionCreator {
  static Action onAgePicker() {
    return Action(IntroductionAction.onAgePicker);
  }
  static Action onChangeRadio(String value) {
    return Action(IntroductionAction.changeRadio, payload: value);
  }

  static Action onChangeGenderRadio(String value) {
    return Action(IntroductionAction.changeGenderRadio, payload: value);
  }
}

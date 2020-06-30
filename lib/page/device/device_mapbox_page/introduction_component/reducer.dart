import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IntroductionState> buildReducer() {
  return asReducer(
    <Object, Reducer<IntroductionState>>{
      IntroductionAction.changeRadio: _onChangeRadio,
      IntroductionAction.changeGenderRadio: _onChangeGenderRadio,
    },
  );
}

IntroductionState _onChangeRadio(IntroductionState state, Action action) {
  var value = action.payload;
  final IntroductionState newState = state.clone();
  newState.userGroupValue = value;
  return newState;
}

IntroductionState _onChangeGenderRadio(IntroductionState state, Action action) {
  var value = action.payload;
  final IntroductionState newState = state.clone();
  newState.genderGroupValue = value;
  return newState;
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChooseApplicationState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChooseApplicationState>>{
      ChooseApplicationAction.changeCamera: _onChangeCamera,
    },
  );
}

ChooseApplicationState _onChangeCamera(
    ChooseApplicationState state, Action action) {
  var nextIndex = action.payload ?? 0;
  final ChooseApplicationState newState = state.clone();
  if (nextIndex > -1) {
    newState.selectCameraIndex = nextIndex;
  }
  return newState;
}

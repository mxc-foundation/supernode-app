import 'package:fish_redux/fish_redux.dart';

enum ChooseApplicationAction { changeCamera }

class ChooseApplicationActionCreator {
  static Action onChangeCamera(int selectIndex) {
    return Action(ChooseApplicationAction.changeCamera,payload: selectIndex);
  }
}

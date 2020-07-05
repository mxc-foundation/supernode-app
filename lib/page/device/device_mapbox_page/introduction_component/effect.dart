import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/select_picker.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/introduction_component/action.dart';
import 'state.dart';

Effect<IntroductionState> buildEffect() {
  return combineEffects(<Object, Effect<IntroductionState>>{
    IntroductionAction.onAgePicker: _onAgePicker,
  });
}

void _onAgePicker(Action action, Context<IntroductionState> ctx) {
  int selectedIndex = -1;
  List<String> ageList = [];
  List.generate(120, (index) => ageList.add((index + 1).toString()));
  selectPicker(
    ctx.context,
    data: ageList,
    value: selectedIndex,
    onSelected: (sIndex) {
      ctx.state.ageController.text = (sIndex + 1).toString();
    },
  );
}

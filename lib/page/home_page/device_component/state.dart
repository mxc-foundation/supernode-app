import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/device_component/device_list_adapter/device_item_component/state.dart';

class DeviceState extends MutableSource implements Cloneable<DeviceState> {
  List list = [DeviceItemState(), DeviceItemState(), DeviceItemState()];

  @override
  Object getItemData(int index) => list[index];

  @override
  String getItemType(int index) => 'item';

  @override
  int get itemCount => list?.length ?? 0;

  @override
  void setItemData(int index, Object data) => list[index] = data;

  @override
  DeviceState clone() {
    return DeviceState();
  }
}

DeviceState initState(Map<String, dynamic> args) {
  return DeviceState();
}

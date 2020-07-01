import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DiscoverComponent extends Component<DiscoverState> {
  DiscoverComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DiscoverState>(
                adapter: null,
                slots: <String, Dependent<DiscoverState>>{
                }),);

}

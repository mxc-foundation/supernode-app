import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FootprintsComponent extends Component<FootprintsState> {
  FootprintsComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<FootprintsState>(
                adapter: null,
                slots: <String, Dependent<FootprintsState>>{
                }),);

}

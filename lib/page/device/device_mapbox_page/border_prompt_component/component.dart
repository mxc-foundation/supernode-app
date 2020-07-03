import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BorderPromptComponent extends Component<BorderPromptState> {
  BorderPromptComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<BorderPromptState>(
                adapter: null,
                slots: <String, Dependent<BorderPromptState>>{
                }),);

}

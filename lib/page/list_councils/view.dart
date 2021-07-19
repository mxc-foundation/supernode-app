import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/council_card.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ListCouncilsState state, Dispatch dispatch, ViewService viewService) {
  final context = viewService.context;

  return GestureDetector(
    key: Key('joinCouncilView'),
    onTap: () => FocusScope.of(viewService.context).unfocus(),
    child: pageFrame(
      context: viewService.context,
      scaffoldKey: state.scaffoldKey,
      children: [
        pageNavBar(
          FlutterI18n.translate(context, 'council'),
          onTap: () => Navigator.of(context).pop(),
        ),
        SizedBox(height: 30),
        Container(
          width: double.infinity,
          child: CupertinoSlidingSegmentedControl<int>(
            children: {
              0: Text(
                FlutterI18n.translate(context, 'joined_council'),
                style: state.tab == 0
                    ? FontTheme.of(context).middle.button()
                    : FontTheme.of(context).middle.label(),
              ),
              1: Text(
                FlutterI18n.translate(context, 'council_lists'),
                style: state.tab == 1
                    ? FontTheme.of(context).middle.button()
                    : FontTheme.of(context).middle.label(),
              ),
            },
            key: ValueKey('tabSlider'),
            onValueChanged: (v) => dispatch(ListCouncilsActionCreator.tab(v)),
            groupValue: state.tab,
            thumbColor: ColorsTheme.of(context).dhxBlue,
            backgroundColor: ColorsTheme.of(context).dhxBlue20,
          ),
        ),
        SizedBox(height: 30),
        if (state.allCouncils == null || state.joinedCouncils == null)
          _loadingWidget(context)
        else
          for (var i = 0; i < state.selectedCouncils.length; i++) ...[
            CouncilCard(
              key: ValueKey('councilItem#$i'),
              council: state.selectedCouncils[i],
            ),
            SizedBox(height: 15),
          ],
      ],
    ),
  );
}

Widget _loadingWidget(BuildContext context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: CircularProgressIndicator(
          key: ValueKey('circularProgressIndicator'),
          valueColor: AlwaysStoppedAnimation(ColorsTheme.of(context).dhxBlue),
        ),
      ),
    );

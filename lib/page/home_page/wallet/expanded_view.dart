import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/page/home_page/state.dart';
import 'package:supernodeapp/page/home_page/wallet/btc_token/page_content.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'mxc_token/page_content.dart';
import 'supernode_dhx_token/page_content.dart';

class TokenExpandedView extends StatefulWidget {
  final Token selectedToken;
  final void Function(Token token) onTokenChanged;

  const TokenExpandedView({
    Key key,
    this.selectedToken,
    this.onTokenChanged,
  }) : super(key: key);

  @override
  _TokenExpandedViewState createState() => _TokenExpandedViewState();
}

class _TokenExpandedViewState extends State<TokenExpandedView>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    final pageIndex = getSelectedTokenIndex();
    controller = TabController(
      initialIndex: pageIndex,
      vsync: this,
      length: context.read<HomeCubit>().state.displayTokens.length,
    );
    controller.addListener(controllerListener);
  }

  void switchController(int pagesCount) {
    final oldController = controller;
    controller = TabController(
        length: pagesCount, vsync: this, initialIndex: getSelectedTokenIndex());
    controller.addListener(controllerListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      oldController.dispose();
    });
  }

  void controllerListener() {
    if (controller.previousIndex != controller.index) {
      widget.onTokenChanged(
        context.read<HomeCubit>().state.displayTokens[controller.index],
      );
    }
  }

  int getSelectedTokenIndex() {
    return context
        .read<HomeCubit>()
        .state
        .displayTokens
        .indexOf(widget.selectedToken);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      buildWhen: (a, b) => a.displayTokens != b.displayTokens,
      listenWhen: (a, b) => a.displayTokens?.length != b.displayTokens?.length,
      listener: (ctx, state) => switchController(state.displayTokens.length),
      builder: (ctx, state) => Column(
        children: [
          Expanded(
            child: TabBarView(
              children: [
                if (state.displayTokens.contains(Token.mxc))
                  MxcTokenPageContent(
                    key: ValueKey('mxcPage'),
                  ),
                if (state.displayTokens.contains(Token.supernodeDhx))
                  SupernodeDhxTokenPageContent(
                    key: ValueKey('supernodeDhxPage'),
                  ),
                if (state.displayTokens.contains(Token.btc))
                  BtcTokenPageContent(
                    key: ValueKey('btcPage'),
                  ),
              ],
              controller: controller,
            ),
          ),
          Visibility(
            visible: state.displayTokens.length > 1,
            child: Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                color: ColorsTheme.of(context).secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    color: boxShadowColor,
                    offset: Offset(0, 2),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: TabIndicators(
                colors: state.displayTokens
                    .map((c) => c.ui(context).color)
                    .toList(),
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabIndicators extends StatefulWidget {
  final TabController controller;
  final List<Color> colors;

  const TabIndicators({Key key, this.controller, this.colors})
      : super(key: key);

  @override
  _TabIndicatorsState createState() => _TabIndicatorsState();
}

class _TabIndicatorsState extends State<TabIndicators> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listener);
  }

  @override
  void dispose() {
    try {
      widget.controller.removeListener(listener);
    } catch (e) {}
    super.dispose();
  }

  void listener() {
    if (widget.controller.index != widget.controller.previousIndex && mounted) {
      setState(() {});
    }
  }

  Widget pageviewIndicator(bool isActive, Color color) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 3),
      height: 5,
      width: isActive ? 20 : 19,
      decoration: BoxDecoration(
        color: isActive ? color : ColorsTheme.of(context).textLabel,
        borderRadius: BorderRadius.all(
          Radius.circular(2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < widget.colors.length; i++)
            if (i == widget.controller.index)
              pageviewIndicator(true, widget.colors[i])
            else
              pageviewIndicator(
                false,
                widget.colors[i],
              ),
        ],
      ),
    );
  }
}

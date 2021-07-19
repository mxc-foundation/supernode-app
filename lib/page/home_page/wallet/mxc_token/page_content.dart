import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/wallet/mxc_token/actions.dart';
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'stake_history.dart';
import 'transaction_history.dart';

class MxcTokenPageContent extends StatefulWidget {
  const MxcTokenPageContent({Key key}) : super(key: key);

  @override
  _MxcTokenPageContentState createState() => _MxcTokenPageContentState();
}

class _MxcTokenPageContentState extends State<MxcTokenPageContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView(
        padding: EdgeInsets.only(bottom: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: MxcActions(
              spaceOut: true,
            ),
          ),
          MxcTokenCard(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: CupertinoSlidingSegmentedControl(
                groupValue: selectedTab,
                onValueChanged: (tabIndex) =>
                    setState(() => selectedTab = tabIndex),
                thumbColor: Token.mxc.ui(context).color,
                children: <int, Widget>{
                  0: Text(
                    FlutterI18n.translate(context, 'transaction_history'),
                    style: TextStyle(
                      color: (selectedTab == 0)
                          ? ColorsTheme.of(context).boxComponents
                          : ColorsTheme.of(context).textLabel,
                    ),
                  ),
                  1: Text(
                    FlutterI18n.translate(context, 'stake_assets'),
                    style: TextStyle(
                      color: (selectedTab == 1)
                          ? ColorsTheme.of(context).boxComponents
                          : ColorsTheme.of(context).textLabel,
                    ),
                  )
                }),
          ),
          if (selectedTab == 0)
            TransactionHistoryContent()
          else
            StakeHistoryContent(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/page/home_page/home_page.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

class DDNavWithSkip extends StatelessWidget {
  final String title;
  final bool hasBack;

  const DDNavWithSkip({
    Key key,
    @required this.title,
    this.hasBack = false,
  }) : super(key: key);

  @override
  Widget build(Object context) {
    return Container(
      padding: kRoundRow0510,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
              width: 100,
              alignment: Alignment.centerLeft,
              child: Visibility(
                  visible: false,
                  child: GestureDetector(
                      child: Icon(Icons.arrow_back_ios_rounded,
                          color: ColorsTheme.of(context).textPrimaryAndIcons),
                      onTap: () => Navigator.of(context).pop()))),
          Spacer(),
          Text(FlutterI18n.translate(context, title),
              style: FontTheme.of(context).big.primary.bold()),
          Spacer(),
          Container(
              width: 100,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        FlutterI18n.translate(context, 'skip'),
                        style: FontTheme.of(context).big(),
                      ),
                    ),
                    onTap: () => navigatorKey.currentState.pushAndRemoveUntil(
                        routeWidget(HomePage()), (_) => false),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () => navigatorKey.currentState
                        .pushAndRemoveUntil(
                            routeWidget(HomePage()), (_) => false),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

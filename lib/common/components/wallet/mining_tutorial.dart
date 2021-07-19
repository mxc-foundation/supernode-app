import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/row_spacer.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/shared.dart';
import 'package:supernodeapp/page/home_page/wallet/supernode_dhx_token/dhx_bonding_page.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class MiningTutorial extends StatefulWidget {
  final BuildContext _ctx;
  List<Widget> _pages;

  MiningTutorial(this._ctx) {
    this._pages = [
      _pageView_1(_ctx),
      _pageView_2(_ctx),
      _pageView_3(_ctx),
      _pageView_4(_ctx),
      _pageView_5(_ctx),
      _pageView_6(_ctx),
      _pageView_7(_ctx)
    ];
  }

  @override
  State<StatefulWidget> createState() => _MiningTutorialState();

  Widget _pageBase(List<Widget> wgts) {
    return Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 20.0),
        child: ListView(children: wgts));
  }

  Widget _pageView_1(BuildContext ctx) {
    return _pageBase([
      Text(FlutterI18n.translate(ctx, "tutorial_pg2_title"),
          style: FontTheme.of(ctx).big()),
      SizedBox(height: s(10)),
      Text(FlutterI18n.translate(ctx, "tutorial_pg2_text"),
          style: FontTheme.of(ctx).big()),
      SizedBox(height: s(30)),
      Row(children: [
        Spacer(),
        Column(children: [
          Text('1', style: FontTheme.of(ctx).veryBig.primary.bold()),
          SizedBox(height: s(10)),
          Container(
              decoration: BoxDecoration(
                  color: Token.supernodeDhx.ui(_ctx).color,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(FlutterI18n.translate(ctx, 'mxc_locked'),
                    style: FontTheme.of(ctx).middle.button()),
              ))
        ]),
        Spacer(),
        Text('=', style: FontTheme.of(ctx).veryBig.primary.bold()),
        Spacer(),
        Column(children: [
          Text('1', style: FontTheme.of(ctx).veryBig.primary.bold()),
          SizedBox(height: s(10)),
          Container(
              decoration: BoxDecoration(
                  color: Token.supernodeDhx.ui(_ctx).color,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Text(FlutterI18n.translate(ctx, 'mxc_locked'),
                        style: TextStyle(
                            color: Colors.transparent,
                            fontFamily: "Roboto",
                            fontSize:
                                14)), // invisible - sets width for Container
                    Text(FlutterI18n.translate(ctx, 'mpower'),
                        style: FontTheme.of(ctx).middle.button())
                  ])))
        ]),
        Spacer(),
      ]),
      SizedBox(height: s(10)),
      Text(
        FlutterI18n.translate(ctx, "tutorial_pg2_desc1"),
        style: FontTheme.of(ctx).middle(),
      ),
      SizedBox(height: s(30)),
      Row(children: [
        Spacer(),
        Column(children: [
          Text('1', style: FontTheme.of(ctx).veryBig.primary.bold()),
          SizedBox(height: s(10)),
          Container(
              decoration: BoxDecoration(
                  color: Token.supernodeDhx.ui(_ctx).color,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Text(FlutterI18n.translate(ctx, 'm2pro_miner'),
                        style: FontTheme.of(ctx).middle.button()),
                  ])))
        ]),
        Spacer(),
        Text('=', style: FontTheme.of(ctx).veryBig.primary.bold()),
        Spacer(),
        Column(children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: '100% ', style: FontTheme.of(ctx).veryBig.primary.bold()),
            TextSpan(text: 'Boost', style: FontTheme.of(ctx).big())
          ])),
          SizedBox(height: s(10)),
          Container(
              decoration: BoxDecoration(
                  color: Token.supernodeDhx.ui(_ctx).color,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Text(FlutterI18n.translate(ctx, 'm2pro_miner'),
                        style: TextStyle(
                            color: Colors.transparent,
                            fontFamily: "Roboto",
                            fontSize:
                                14)), // invisible - sets width for Container
                    Text(FlutterI18n.translate(ctx, 'mpower'),
                        style: FontTheme.of(ctx).middle.button())
                  ])))
        ]),
        Spacer(),
      ]),
      SizedBox(height: s(10)),
      Text(
        FlutterI18n.translate(ctx, "tutorial_pg2_desc2"),
        style: FontTheme.of(ctx).middle(),
      ),
      SizedBox(height: s(30)),
      Row(children: [
        Spacer(),
        Column(children: [
          Text('1', style: FontTheme.of(ctx).veryBig.primary.bold()),
          SizedBox(height: s(10)),
          Container(
              decoration: BoxDecoration(
                  color: Token.supernodeDhx.ui(_ctx).color,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Text(FlutterI18n.translate(ctx, 'm2pro_miner'),
                        style: FontTheme.of(ctx).middle.button()),
                  ])))
        ]),
        Spacer(),
        Text('=', style: FontTheme.of(ctx).veryBig.primary.bold()),
        Spacer(),
        Column(children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: FlutterI18n.translate(ctx, 'up_to'),
                style: FontTheme.of(ctx).big()),
            TextSpan(
                text: ' 1 mil.',
                style: FontTheme.of(ctx).veryBig.primary.bold())
          ])),
          SizedBox(height: s(10)),
          Container(
              decoration: BoxDecoration(
                  color: Token.supernodeDhx.ui(_ctx).color,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Text(FlutterI18n.translate(ctx, 'm2pro_miner'),
                        style: TextStyle(
                            color: Colors.transparent,
                            fontFamily: "Roboto",
                            fontSize:
                                14)), // invisible - sets width for Container
                    Text(FlutterI18n.translate(ctx, 'mpower'),
                        style: FontTheme.of(ctx).middle.button())
                  ])))
        ]),
        Spacer(),
      ]),
      SizedBox(height: s(10)),
      Text(
        FlutterI18n.translate(ctx, "tutorial_pg2_desc2_2"),
        style: FontTheme.of(ctx).middle(),
      ),
      SizedBox(height: s(30)),
      Column(children: [
        Icon(Icons.calendar_today),
        SizedBox(height: s(10)),
        Container(
            decoration: BoxDecoration(
                color: Token.supernodeDhx.ui(_ctx).color,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(FlutterI18n.translate(ctx, 'mining_term'),
                    style: FontTheme.of(ctx).middle.button())))
      ]),
      SizedBox(height: s(10)),
      Text(
        FlutterI18n.translate(ctx, "tutorial_pg2_desc3"),
        style: FontTheme.of(ctx).middle(),
      ),
      SizedBox(height: 25)
    ]);
  }

  Widget _pageView_2(BuildContext ctx) {
    return _pageBase([
      RichText(
          text: TextSpan(children: [
        TextSpan(
            text: FlutterI18n.translate(ctx, "tutorial_pv2_title_span1"),
            style: FontTheme.of(ctx).big()),
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv2_title_span2"),
          style: FontTheme.of(ctx).big.dhx(),
        ),
      ])),
      SizedBox(height: 70),
      Row(children: [
        Container(
            decoration: BoxDecoration(
                color: Token.supernodeDhx.ui(_ctx).color,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Text('40% ' + FlutterI18n.translate(ctx, 'boost'),
                  style: FontTheme.of(ctx).middle.button()),
            )),
        Spacer(),
        Container(
            decoration: BoxDecoration(
                color: Token.supernodeDhx.ui(_ctx).color,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text('0% ' + FlutterI18n.translate(ctx, 'boost'),
                  style: FontTheme.of(ctx).middle.button()),
            ))
      ]),
      Image.asset(AppImages.minerBoostGraph, height: 200),
      Row(children: [
        Container(
            decoration: BoxDecoration(
                color: Token.supernodeDhx.ui(_ctx).color,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Text('20% ' + FlutterI18n.translate(ctx, 'boost'),
                  style: FontTheme.of(ctx).middle.button()),
            )),
        Spacer(),
        Container(
            decoration: BoxDecoration(
                color: Token.supernodeDhx.ui(_ctx).color,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Text('10% ' + FlutterI18n.translate(ctx, 'boost'),
                  style: FontTheme.of(ctx).middle.button()),
            ))
      ]),
      SizedBox(height: 25)
    ]);
  }

  Widget _pageView_3(BuildContext ctx) {
    return _pageBase([
      Text(FlutterI18n.translate(ctx, "tutorial_pv3_title"),
          style: FontTheme.of(ctx).big()),
      smallColumnSpacer(),
      RichText(
          text: TextSpan(children: [
        TextSpan(
            text: FlutterI18n.translate(ctx, "tutorial_pv3_text_span1"),
            style: FontTheme.of(ctx).big()),
        TextSpan(
            text: FlutterI18n.translate(ctx, "tutorial_pv3_text_span2"),
            style: FontTheme.of(ctx).big.dhx()),
        TextSpan(
            text: FlutterI18n.translate(ctx, "tutorial_pv3_text_span3"),
            style: FontTheme.of(ctx).big()),
        TextSpan(
            text: FlutterI18n.translate(ctx, "tutorial_pv3_text_span4"),
            style: FontTheme.of(ctx).big.dhx()),
        TextSpan(
            text: FlutterI18n.translate(ctx, "tutorial_pv3_text_span5"),
            style: FontTheme.of(ctx).big()),
        TextSpan(
            text: FlutterI18n.translate(ctx, "tutorial_pv3_text_span6"),
            style: FontTheme.of(ctx).big.dhx()),
        TextSpan(
            text: FlutterI18n.translate(ctx, "tutorial_pv3_text_span7"),
            style: FontTheme.of(ctx).big()),
      ])),
      Image.asset(AppImages.council, color: Token.supernodeDhx.ui(_ctx).color),
      middleColumnSpacer(),
    ]);
  }

  Widget _pageView_4(BuildContext ctx) {
    return _pageBase([
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv4_title_span1"),
          style: FontTheme.of(ctx).big(),
        ),
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv4_title_span2"),
          style: FontTheme.of(ctx).big.dhx(),
        ),
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv4_title_span3"),
          style: FontTheme.of(ctx).big(),
        ),
      ])),
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv4_title_span4"),
          style: FontTheme.of(ctx).big(),
        ),
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv4_title_span5"),
          style: FontTheme.of(ctx).big.dhx(),
        ),
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv4_title_span6"),
          style: FontTheme.of(ctx).big(),
        ),
      ])),
      SizedBox(height: s(30)),
      Image.asset(AppImages.calendar1),
    ]);
  }

  Widget _pageView_5(BuildContext ctx) {
    return _pageBase([
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv5_title_span1"),
          style: FontTheme.of(ctx).big.dhx(),
        ),
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv5_title_span2"),
          style: FontTheme.of(ctx).big(),
        ),
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv5_title_span3"),
          style: FontTheme.of(ctx).big.dhx(),
        ),
      ])),
      SizedBox(height: s(10)),
      Text(FlutterI18n.translate(ctx, "tutorial_pv5_text"),
          style: FontTheme.of(ctx).big()),
      SizedBox(height: s(30)),
      Image.asset(AppImages.calendar2),
    ]);
  }

  Widget _pageView_6(BuildContext ctx) {
    return _pageBase([
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv6_title_span1"),
          style: FontTheme.of(ctx).big(),
        ),
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv6_title_span2"),
          style: FontTheme.of(ctx).big.dhx(),
        ),
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv6_title_span3"),
          style: FontTheme.of(ctx).big(),
        ),
        TextSpan(
          text: FlutterI18n.translate(ctx, "tutorial_pv6_title_span4"),
          style: FontTheme.of(ctx).big.dhx(),
        ),
      ])),
      SizedBox(height: s(10)),
      Text(FlutterI18n.translate(ctx, "tutorial_pv6_text"),
          style: FontTheme.of(ctx).big()),
      SizedBox(height: s(30)),
      Image.asset(AppImages.calendar3),
    ]);
  }

  Widget _pageView_7(BuildContext ctx) {
    return _pageBase([
      SizedBox(height: s(40)),
      Center(child: Image.asset(AppImages.rocket, width: 100, height: 100)),
      SizedBox(height: 25),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
              color: Token.supernodeDhx.ui(_ctx).color,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text(
            FlutterI18n.translate(ctx, 'dhx_mining').toUpperCase(),
            style: FontTheme.of(ctx).big.button(),
          ),
        ),
      ),
      middleColumnSpacer(),
      Text(
        FlutterI18n.translate(ctx, 'wallet'),
        style: FontTheme.of(ctx).middle.secondary(),
      ),
      smallColumnSpacer(),
      GestureDetector(
        onTap: () => openSupernodeDeposit(ctx, Token.supernodeDhx),
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: ColorsTheme.of(ctx).secondaryBackground,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: ColorsTheme.of(ctx).primaryBackground,
                    offset: Offset(0, 2),
                    blurRadius: 7,
                    spreadRadius: 0.0,
                  )
                ]),
            child: Row(children: [
              CircleButton(
                icon: Icon(
                  Icons.add,
                  color: Token.supernodeDhx.ui(_ctx).color,
                ),
              ),
              smallRowSpacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FlutterI18n.translate(ctx, 'deposit_dhx'),
                    style: FontTheme.of(ctx).big(),
                  ),
                  Text(
                    FlutterI18n.translate(ctx, 'tutorial_pv7_sub1'),
                    style: FontTheme.of(ctx).small(),
                  )
                ],
              )
            ])),
      ),
      middleColumnSpacer(),
      Text(
        FlutterI18n.translate(ctx, 'tutorial_pv7_label'),
        style: FontTheme.of(ctx).middle.secondary(),
      ),
      smallColumnSpacer(),
      GestureDetector(
        onTap: () => Navigator.pushNamed(ctx, 'lock_page',
            arguments: {'isDemo': ctx.read<AppCubit>().state.isDemo}),
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: ColorsTheme.of(ctx).secondaryBackground,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: ColorsTheme.of(ctx).primaryBackground,
                    offset: Offset(0, 2),
                    blurRadius: 7,
                    spreadRadius: 0.0,
                  )
                ]),
            child: Row(children: [
              CircleButton(
                icon: Icon(
                  Icons.lock,
                  color: Token.supernodeDhx.ui(_ctx).color,
                ),
              ),
              smallRowSpacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FlutterI18n.translate(ctx, 'lock_mxc'),
                    style: FontTheme.of(ctx).big(),
                  ),
                  Text(
                    FlutterI18n.translate(ctx, 'tutorial_pv7_sub2'),
                    style: FontTheme.of(ctx).small(),
                  )
                ],
              )
            ])),
      ),
      smallColumnSpacer(),
      GestureDetector(
        onTap: () => Navigator.push(ctx, routeWidget(DhxBondingPage())),
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorsTheme.of(ctx).secondaryBackground,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: ColorsTheme.of(ctx).primaryBackground,
                  offset: Offset(0, 2),
                  blurRadius: 7,
                  spreadRadius: 0.0,
                )
              ],
            ),
            child: Row(children: [
              CircleButton(
                icon: Image.asset(
                  AppImages.iconBond,
                  color: Token.supernodeDhx.ui(_ctx).color,
                ),
              ),
              smallRowSpacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FlutterI18n.translate(ctx, 'bond_dhx'),
                    style: FontTheme.of(ctx).big(),
                  ),
                  Text(
                    FlutterI18n.translate(ctx, 'tutorial_pv7_sub3'),
                    style: FontTheme.of(ctx).small(),
                  )
                ],
              )
            ])),
      ),
    ]);
  }
}

class _MiningTutorialState extends State<MiningTutorial> {
  int currentTutorialPageValue = 0;
  int currentPageViewValue = 0;

  Widget _page_1(BuildContext ctx) {
    return widget._pageBase([
      smallColumnSpacer(),
      Text(FlutterI18n.translate(ctx, "tutorial_page1_title"),
          key: Key('tutorialPage1Title'), style: FontTheme.of(ctx).big()),
      middleColumnSpacer(),
      Image.asset(AppImages.dhxMiningDiagram),
      middleColumnSpacer(),
      PrimaryButton(
          buttonTitle: FlutterI18n.translate(context, 'next'),
          bgColor: Token.supernodeDhx.ui(ctx).color,
          minWidth: double.infinity,
          onTap: () => setState(() => currentTutorialPageValue = 1))
    ]);
  }

  Widget _page_2(BuildContext ctx) {
    return widget._pageBase([
      Text(FlutterI18n.translate(ctx, "tutorial_page2_title"),
          style: FontTheme.of(ctx).big()),
      bigColumnSpacer(),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleButton(
          icon: Icon(
            Icons.lock,
            color: Token.supernodeDhx.ui(ctx).color,
          ),
          onTap: () => '',
        ),
        SizedBox(width: 20),
        Flexible(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('1. ${FlutterI18n.translate(context, 'lock_mxc')}',
                style: FontTheme.of(context).big.primary.bold()),
            Text(FlutterI18n.translate(context, 'tutorial_page2_txt1'),
                style: FontTheme.of(context).middle()),
          ]),
        )
      ]),
      middleColumnSpacer(),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleButton(
          icon: Image.asset(
            AppImages.bottomBarMenus['gateway'],
            color: Token.supernodeDhx.ui(ctx).color,
          ),
          onTap: () => '',
        ),
        SizedBox(width: 20),
        Flexible(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('2. ${FlutterI18n.translate(context, 'add_miner')}',
                style: FontTheme.of(context).big.primary.bold()),
            Text(FlutterI18n.translate(context, 'tutorial_page2_txt2'),
                style: FontTheme.of(context).middle()),
          ]),
        )
      ]),
      middleColumnSpacer(),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleButton(
          icon: Icon(
            Icons.add,
            color: Token.supernodeDhx.ui(ctx).color,
          ),
          onTap: () => '',
        ),
        SizedBox(width: 20),
        Flexible(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('3. ${FlutterI18n.translate(context, 'deposit_dhx')}',
                style: FontTheme.of(context).big.primary.bold()),
            Text(FlutterI18n.translate(context, 'tutorial_page2_txt3'),
                style: FontTheme.of(context).middle()),
          ]),
        )
      ]),
      middleColumnSpacer(),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleButton(
          icon: Image.asset(
            AppImages.iconBond,
            color: Token.supernodeDhx.ui(ctx).color,
          ),
          onTap: () => '',
        ),
        SizedBox(width: 20),
        Flexible(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('4. ${FlutterI18n.translate(context, 'bond_dhx')}',
                style: FontTheme.of(context).big.primary.bold()),
            Text(FlutterI18n.translate(context, 'tutorial_page2_txt4'),
                style: FontTheme.of(context).middle()),
          ]),
        )
      ]),
      xbigColumnSpacer(),
      PrimaryButton(
          buttonTitle: FlutterI18n.translate(context, 'lets_go_learn_button'),
          bgColor: Token.supernodeDhx.ui(ctx).color,
          minWidth: double.infinity,
          onTap: () => setState(() => currentTutorialPageValue = 2))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      Visibility(
          visible: (currentTutorialPageValue == 0), child: _page_1(context)),
      Visibility(
          visible: (currentTutorialPageValue == 1), child: _page_2(context)),
      Visibility(
        visible: (currentTutorialPageValue == 2),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView(
              onPageChanged: (int page) {
                currentPageViewValue = page;
                setState(() {});
              },
              children: widget._pages,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < widget._pages.length; i++)
                          if (i == currentPageViewValue) ...[
                            circleBar(context, true)
                          ] else
                            circleBar(context, false),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ]);
  }

  Widget circleBar(BuildContext context, bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? Token.supernodeDhx.ui(context).color
            : ColorsTheme.of(context).boxComponents,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

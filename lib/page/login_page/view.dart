import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/common/components/expansion_super_node_tile.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_list.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/data/super_node_bean.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  
  return Scaffold(
    key: state.scaffoldKey,
    backgroundColor: cardBackgroundColor,
    body: GestureDetector(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          key: Key('homeLogo'),
                          onTap: () => dispatch(LoginActionCreator.clickLogo()),
                          child: Container(
                            color: darkBackground,
                            height: s(218),
                            padding: EdgeInsets.only(bottom: s(106)),
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(AppImages.splashLogo, height: s(48)),
                          ),
                        ),
                        SizedBox(height: s(100)),
                        Row(
                          mainAxisAlignment : MainAxisAlignment.center,
                          children: [
                            Text(
                              FlutterI18n.translate(_ctx, 'choose_supernode'),
                              style: TextStyle(fontSize: s(14), fontWeight: FontWeight.w400, color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () => _showInfoDialog(_ctx),
                              child: Padding(
                                key: Key("questionCircle"),
                                padding: EdgeInsets.all(s(5)),
                                child: Image.asset(AppImages.questionCircle, height: s(20)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: s(133),
                      child: GestureDetector(
                        key: Key('homeSupernodeMenu'),
                        onTap: () => dispatch(LoginActionCreator.superNodeListVisible(true)),
                        child: ClipOval(
                          child: Container(
                            width: s(171),
                            height: s(171),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              width: s(134),
                              height: s(134),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
                                BoxShadow(
                                  color: darkBackground,
                                  offset: Offset(0, 2),
                                  blurRadius: 20,
                                  spreadRadius: 10,
                                )
                              ]),
                              child: (state.currentSuperNode != null)
                                  ? CachedNetworkImage(
                                      imageUrl: state.currentSuperNode.logo,
                                      placeholder: (a, b) => Image.asset(
                                        AppImages.placeholder,
                                        width: s(100),
                                      ),
                                      width: s(100),
                                    )
                                  : Icon(Icons.add, size: s(25)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s(16)),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: state.formKey,
                        autovalidate: false,
                        child: Column(children: <Widget>[
                          Container(
                            margin: kOuterRowTop35,
                            child: TextFieldWithList(
                              key: Key('homeEmail'),
                              title: FlutterI18n.translate(_ctx, 'email'),
                              hint: FlutterI18n.translate(_ctx, 'email_hint'),
                              textInputAction: TextInputAction.next,
                              validator: (value) => Reg.onValidEmail(_ctx, value),
                              controller: state.usernameCtl,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: TextFieldWithTitle(
                              key: Key('homePassword'),
                              title: FlutterI18n.translate(_ctx, 'password'),
                              hint: FlutterI18n.translate(_ctx, 'password_hint'),
                              isObscureText: state.isObscureText,
                              validator: (value) => Reg.onValidPassword(_ctx, value),
                              controller: state.passwordCtl,
                              suffixChild: IconButton(icon: Icon(state.isObscureText ? Icons.visibility_off : Icons.visibility), onPressed: () => dispatch(LoginActionCreator.isObscureText())),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: s(12)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => dispatch(LoginActionCreator.onDemo()),
                            child: Text(
                              FlutterI18n.translate(_ctx, 'demo'),
                              style: TextStyle(fontSize: s(12), color: hintFont),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => dispatch(LoginActionCreator.onForgotPasswordAction()),
                            child: Text(
                              FlutterI18n.translate(_ctx, 'forgot_hint'),
                              style: TextStyle(fontSize: s(12), color: hintFont),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: s(18)),
                      PrimaryButton(key: Key('homeLogin'), onTap: () => dispatch(LoginActionCreator.onLogin()), buttonTitle: FlutterI18n.translate(_ctx, 'login'), minHeight: s(46), minWidget: double.infinity),
                      Container(
                        margin: EdgeInsets.only(top: s(28.5), bottom: s(17.5)),
                        height: s(1),
                        color: darkBackground,
                      ),
                      Text(
                        FlutterI18n.translate(_ctx, 'access_using'),
                        style: TextStyle(fontSize: s(14), color: tipFont),
                      ),
                      SizedBox(height: s(29)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleButton(
                            onTap: () => dispatch(LoginActionCreator.onSignUp()),
                            icon: Image.asset(AppImages.email, width: 22, height: 22,),
                          ),
                          SizedBox(width: s(30)),
                          CircleButton(icon: null),
                          SizedBox(width: s(30)),
                          CircleButton(icon: null),
                        ],
                      ),
                      SizedBox(height: s(20)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (state.showSuperNodeList)
            GestureDetector(
              onTap: () => dispatch(LoginActionCreator.superNodeListVisible(false)),
              child: Container(
                color: Color(0x33000000),
              ),
            ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: state.showSuperNodeList ? 0 : -ScreenUtil.instance.width,
            child: Container(
              height: ScreenUtil.instance.height,
              width: s(304),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(s(10)),
                  bottomRight: Radius.circular(s(10)),
                ),
              ),
              child: SingleChildScrollView(
                key: Key('scrollMenu'),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: s(114),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            FlutterI18n.translate(_ctx, 'super_node'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: s(16),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Positioned(
                          right: s(15),
                          child: GestureDetector(
                            onTap: () => dispatch(LoginActionCreator.superNodeListVisible(false)),
                            child: Icon(Icons.close, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      for (var key in state.superNodes?.keys ?? [])
                        if (key != "Test" || state.count == 7)
                          ExpansionSuperNodesTile(
                            title: Text(FlutterI18n.translate(_ctx, key), style: TextStyle(color: Colors.black)),
                            initiallyExpanded: true,
                            backgroundColor: darkBackground,
                            children: <Widget>[
                              for (SuperNodeBean item in state.superNodes[key])
                                GestureDetector(
                                  child: ListTile(
                                    title: Container(
                                      key: Key(item.name),
                                      alignment: Alignment.center,
                                      height: s(65),
                                      child: CachedNetworkImage(
                                        imageUrl: "${item.logo}",
                                        placeholder: (a, b) => Image.asset(
                                          AppImages.placeholder,
                                          height: s(30),
                                        ),
                                        height: s(30),
                                      ),
                                    ),
                                  ),
                                  onTap: () => dispatch(LoginActionCreator.selectedSuperNode(item)),
                                ),
                            ],
                          ),
                    ],
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
      onTap: () {
        FocusScope.of(_ctx).requestFocus(FocusNode());
      },
    ));
}

void _showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FullScreenDialog(
        child: IosStyleBottomDialog2(
            context: context,
            child: Column(
              children: [
                Container(
                  width: s(86),
                  height: s(86),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: s(67),
                    height: s(67),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: darkBackground,
                        offset: Offset(0, 1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      )
                    ]),
                    child: Icon(Icons.add, size: s(12)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(FlutterI18n.translate(context, 'info_supernode'),
                      key: ValueKey("helpText"),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: s(16),
                        fontWeight: FontWeight.w500,
                      ),
                    textAlign: TextAlign.center,
                  )
                ),
              ],
            )
        ),
      );
    },
  );
}

//Sys.superNodes.keys
//    .map(
//(node) => Container(
//child: SupernodeButton(onPress: () => dispatch(LoginActionCreator.selectedSuperNode(node)), selected: state.selectedSuperNode.contains(node), cardChild: Image.asset(AppImages.superNodes[node])),
//),
//)
//.toList(),

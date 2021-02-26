import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/expansion_super_node_tile.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.model.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/home_page.dart';
import 'package:supernodeapp/page/login_page/supernode_login_page/cubit.dart';
import 'package:supernodeapp/page/login_page/supernode_login_page/state.dart';
import 'package:supernodeapp/page/sign_up_page/verification_code_component/email_verification_page.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../../route.dart';

class SupernodeSignupPage extends StatefulWidget {

  @override
  _SupernodeSignupPageState createState() => _SupernodeSignupPageState();
}

class _SupernodeSignupPageState extends State<SupernodeSignupPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  Loading loading;

  void clickTitle() {
    context.read<LoginCubit>().increaseTestCounter();
  }

  void onSupernodeSelect(Supernode item) {
    context.read<LoginCubit>().setSelectedSuperNode(item);
    context.read<LoginCubit>().setSuperNodeListVisible(false);
  }

  void onSignupEmail() {
    if (context.read<LoginCubit>().state.selectedSuperNode == null) {
      tip(context, FlutterI18n.translate(context, 'reg_select_supernode'));
      return;
    }
    if (!formKey.currentState.validate()) return;
    final email = emailController.text.trim();
    context.read<LoginCubit>().signupEmail(email, Localizations.localeOf(context).languageCode);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (a, b) => a.showLoading != b.showLoading,
          listener: (ctx, state) async {
            loading?.hide();
            if (state.showLoading) {
              loading = Loading.show(ctx);
            }
          },
        ),
        BlocListener<AppCubit, AppState>(
          listenWhen: (a, b) => a.error != b.error,
          listener: (ctx, state) async {
            if (state.error == null) return;
            final message = state.error.text;
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: errorColor,
            ));
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (a, b) => a.signupResult != b.signupResult,
          listener: (ctx, state) async {
            if (state.signupResult == null) return;
            switch (state.signupResult) {
              case SignupResult.home:
                await navigatorKey.currentState
                    .pushAndRemoveUntil(route((c) => HomePage()), (_) => false);
                break;
              case SignupResult.verifyEmail:
                Navigator.of(context).push(route((ctx) => EmailVerificationPage()));
                break;
            }
          },
        ),
      ],
      child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: cardBackgroundColor,
          body: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: s(133),
                  child: GestureDetector(
                    key: Key('homeSupernodeMenu'),
                    onTap: () => context
                        .read<LoginCubit>()
                        .setSuperNodeListVisible(true),
                    child: ClipOval(
                      child: Container(
                        width: s(171),
                        height: s(171),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: darkBackground,
                          shape: BoxShape.circle,
                        ),
                        child: BlocBuilder<LoginCubit, LoginState>(
                          buildWhen: (a, b) =>
                          a.selectedSuperNode !=
                              b.selectedSuperNode,
                          builder: (context, state) =>
                          state.selectedSuperNode != null
                              ? Container(
                              width: s(134),
                              height: s(134),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: darkBackground2,
                                      offset: Offset(0, 2),
                                      blurRadius: 5,
                                      spreadRadius: 5,
                                    )
                                  ]),
                              child: CachedNetworkImage(
                                imageUrl: state
                                    .selectedSuperNode.logo,
                                placeholder: (ctx, url) => Icon(Icons.add, size: s(40)),
                                width: s(100),
                              ))
                              : Image.asset(
                            AppImages.supernode_placeholder,
                            width: s(171),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                    child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            AppBars.backArrowAppBar(
                              color: Colors.white,
                              title: FlutterI18n.translate(context, 'create_account'),
                              onPress: () => Navigator.of(context).pop(),
                              onTitlePress: () => clickTitle(),
                            ),
                            SizedBox(height: s(230)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  FlutterI18n.translate(
                                      context, 'choose_supernode'),
                                  style: TextStyle(
                                      fontSize: s(14),
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () => _showInfoDialog(context),
                                  child: Padding(
                                    key: Key("questionCircle"),
                                    padding: EdgeInsets.all(s(5)),
                                    child: Image.asset(AppImages.questionCircle,
                                        height: s(20)),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: s(16)),
                            Form(
                              key: formKey,
                              autovalidate: false,
                              child: Column(children: <Widget>[
                                Container(
                                  padding: kRoundRow202,
                                  child: TextFieldWithTitle(
                                    title: FlutterI18n.translate(context, 'email'),
                                    textInputAction: TextInputAction.done,
                                    validator: (value) => Reg.onValidEmail(context, value),
                                    controller: emailController,
                                  ),
                                ),
                              ]),
                            ),
                            Spacer(),
                            PrimaryButton(
                                padding: kRoundRow205,
                                onTap: () => onSignupEmail(),
                                buttonTitle: FlutterI18n.translate(context, 'continue'),
                                minHeight: 46),
                          ],
                        )
                    )
                ),

                /* Drawer */
                BlocBuilder<LoginCubit, LoginState>(
                  buildWhen: (a, b) =>
                  a.supernodeListVisible != b.supernodeListVisible,
                  builder: (context, state) {
                    if (state.supernodeListVisible)
                      return GestureDetector(
                        onTap: () => context
                            .read<LoginCubit>()
                            .setSuperNodeListVisible(false),
                        child: Container(
                          color: Color(0x33000000),
                        ),
                      );
                    return Container();
                  },
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  buildWhen: (a, b) =>
                  a.supernodeListVisible != b.supernodeListVisible ||
                      a.showTestNodes != b.showTestNodes ||
                      a.supernodes != b.supernodes,
                  builder: (context, state) {
                    return AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      left: state.supernodeListVisible
                          ? 0
                          : -ScreenUtil.instance.width,
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
                            SizedBox(height: 50),
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                      FlutterI18n.translate(
                                          context, 'super_node'),
                                      style: kBigBoldFontOfBlack
                                  ),
                                ),
                                Positioned(
                                  right: s(15),
                                  child: GestureDetector(
                                    onTap: () => context
                                        .read<LoginCubit>()
                                        .setSuperNodeListVisible(false),
                                    child: Icon(Icons.close, size: 24),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                FlutterI18n.translate(context, 'supernode_instructions'),
                                style: kSecondaryButtonOfBlack,
                                textAlign: TextAlign.center,),
                            ),
                            if (!state.supernodes.loading)
                              Column(
                                children: <Widget>[
                                  for (var key
                                  in state.supernodes.value?.keys ?? [])
                                    if (key != "Test" || state.showTestNodes)
                                      ExpansionSuperNodesTile(
                                        title: Text(
                                          FlutterI18n.translate(context, key),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        initiallyExpanded: false,
                                        backgroundColor: darkBackground,
                                        children: <Widget>[
                                          for (Supernode item
                                          in state.supernodes.value[key])
                                            GestureDetector(
                                                child: ListTile(
                                                  title: Container(
                                                    key: Key(item.name),
                                                    alignment: Alignment.center,
                                                    height: s(65),
                                                    child: CachedNetworkImage(
                                                      imageUrl: "${item.logo}",
                                                      placeholder: (a, b) =>
                                                          Image.asset(
                                                            AppImages.placeholder,
                                                            height: s(30),
                                                          ),
                                                      height: s(30),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () => onSupernodeSelect(item)
                                            ),
                                        ],
                                      ),
                                ],
                              ),
                          ]),
                        ),
                      ),
                    );
                  },
                )
              ]
          )
      ),
    );
  }
}

void _showInfoDialog(BuildContext context) {
  showInfoDialog(
    context,
    IosStyleBottomDialog2(
      builder: (context) => Column(
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
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
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
            child: Text(
              FlutterI18n.translate(context, 'info_supernode'),
              key: ValueKey("helpText"),
              style: TextStyle(
                color: Colors.black,
                fontSize: s(16),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
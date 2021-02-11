import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/theme/font.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController shopifyEmailController = TextEditingController();
  final TextEditingController shopifyVerificationCodeControler = TextEditingController();

  Loading loading;

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    shopifyEmailController.dispose();
    shopifyVerificationCodeControler.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget unbindWeChatConfirmation() {
      return Material(
        color: Colors.white,
        child: Stack(alignment: Alignment.topRight, children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              child: Icon(Icons.close, color: Colors.black),
              onTap: () => context.read<SettingsCubit>().showWechatUnbindConfirmation(false),
            ),
          ),
          Column(children: [
            Spacer(),
            Image.asset(AppImages.warningRobot),
            Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                    buildWhen: (a, b) => a.username != b.username,
                    builder: (ctx, s) =>
                        Text(
                          FlutterI18n.translate(context, 'confirm_wechat_unbind').replaceFirst('{0}', s.username),
                          style: kMiddleFontOfBlack,
                          textAlign: TextAlign.center,
                        ))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                  buildWhen: (a, b) => a.weChatUser != b.weChatUser,
                  builder: (ctx, s) =>
                      PrimaryButton(
                          onTap: () => context.read<SettingsCubit>().onUnbind(ExternalUser.weChatService, context.read<SupernodeCubit>().state.orgId),
                          buttonTitle:
                          FlutterI18n.translate(context, 'unbind_wechat_button')
                              .replaceFirst(
                              '{0}', s.weChatUser?.externalUsername ?? ''),
                          minWidget: double.infinity),
                )),
            Spacer(),
          ])
        ]),
      );
    }

    Widget bindShopifyStep1() {
      return Material(
        color: Colors.white,
        child: Stack(alignment: Alignment.topRight, children: [
          Padding(
            padding:
            const EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
            child: Column(children: [
              SizedBox(height: 20),
              Text(FlutterI18n.translate(context, 'shopify_email_instruction'),
                  style: kBigBoldFontOfBlack),
              SizedBox(height: 30),
              TextFieldWithTitle(
                title: FlutterI18n.translate(context, 'email'),
                controller: shopifyEmailController,
              ),
              Spacer(),
              PrimaryButton(
                  buttonTitle: FlutterI18n.translate(context, 'continue'),
                  onTap: () => context.read<SettingsCubit>().shopifyEmail(
                      shopifyEmailController.text,
                      context.read<SupernodeCubit>().state.orgId,
                      FlutterI18n.currentLocale(context).languageCode,
                      FlutterI18n.currentLocale(context).countryCode),
                  minHeight: 45,
                  minWidget: double.infinity)
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              child: Icon(Icons.close, color: Colors.black),
              onTap: () => context.read<SettingsCubit>().bindShopifyStep(0),
            ),
          ),
        ]),
      );
    }

    Widget bindShopifyStep2() {
      return Material(
        color: Colors.white,
        child: Stack(alignment: Alignment.topRight, children: [
          Padding(
            padding:
            const EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
            child: Column(children: [
              SizedBox(height: 20),
              Text(FlutterI18n.translate(context, 'send_email'),
                  style: kBigFontOfBlack),
              SizedBox(height: 30),
              PrimaryTextField(controller: shopifyVerificationCodeControler),
              Spacer(),
              PrimaryButton(
                  buttonTitle: FlutterI18n.translate(context, 'continue'),
                  onTap: () =>
                      context.read<SettingsCubit>().shopifyEmailVerification(
                          shopifyVerificationCodeControler.text,
                          context.read<SupernodeCubit>().state.orgId),
                  minHeight: 45,
                  minWidget: double.infinity)
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              child: Icon(Icons.close, color: Colors.black),
              onTap: () => context.read<SettingsCubit>().bindShopifyStep(0),
            ),
          ),
        ]),
      );
    }

    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (a, b) => a.showLoading != b.showLoading,
      listener: (ctx, state) async {
        loading?.hide();
        if (state.showLoading) {
          loading = Loading.show(ctx);
        }
      },
      child: Stack(children: [
        pageFrame(context: context, children: [
          pageNavBar(
            FlutterI18n.translate(context, 'super_node'),
            onTap: () => Navigator.pop(context),
            leadingWidget: GestureDetector(
              key: ValueKey('navBackButton'),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          pageNavBar(FlutterI18n.translate(context, 'super_node'),
              onTap: () => Navigator.pop(context)),
          Center(
            child: BlocBuilder<SupernodeCubit, SupernodeState>(
              buildWhen: (a, b) => a.session?.node != b.session?.node,
              builder: (ctx, state) => CachedNetworkImage(
                imageUrl: state.session?.node?.logo ?? '',
                placeholder: (a, b) => Image.asset(
                  AppImages.placeholder,
                  height: s(40),
                ),
                height: s(40),
              ),
            ),
          ),
          Center(
            child: Icon(
              Icons.account_circle,
              size: 44,
              color: Colors.black45,
            ),
          ),
          Center(
            child: BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                buildWhen: (a, b) => a.username != b.username,
                builder: (ctx, s) =>
                    Text(
                      s.username,
                      style: kBigFontOfBlack,
                    )),
          ),
          Form(
            //TODO key: state.formKey,
            child: Column(children: <Widget>[
              TextFieldWithTitle(
                title: FlutterI18n.translate(context, 'username'),
                validator: (value) => _validUsername(context, value),
                controller: usernameController,
              ),
              smallColumnSpacer(),
              TextFieldWithTitle(
                title: FlutterI18n.translate(context, 'email'),
                validator: (value) => _validEmail(context, value),
                controller: emailController,
              ),
            ]),
          ),
          submitButton(FlutterI18n.translate(context, 'update'),
              onPressed: () => context.read<SettingsCubit>().update(usernameController.text, emailController.text)),
          BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
              buildWhen: (a, b) => a.weChatUser != b.weChatUser,
              builder: (ctx, s) =>
              (s.weChatUser != null)
                  ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Divider(color: Colors.grey),
                  ),
                  PrimaryButton(
                    // WeChat account
                    onTap: () => context.read<SettingsCubit>().showWechatUnbindConfirmation(true),
                    buttonTitle: FlutterI18n.translate(
                        context, 'unbind_wechat_button')
                        .replaceFirst('{0}', s.weChatUser?.externalUsername),
                    minHeight: 45,
                    minWidget: double.infinity,
                  ),
                ],
              )
                  : SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Divider(color: Colors.grey),
          ),
          BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
              buildWhen: (a, b) => a.weChatUser != b.weChatUser,
              builder: (ctx, s) =>
                  PrimaryButton(
                    // Shopify account
                      onTap: () => (s.shopifyUser == null)
                      ? context.read<SettingsCubit>().bindShopifyStep(1)
                      : context.read<SettingsCubit>().onUnbind(ExternalUser.shopifyService, context.read<SupernodeCubit>().state.orgId),
                      buttonTitle: FlutterI18n.translate(
                          context,
                          (s.shopifyUser == null)
                              ? 'bind_shopify_button'
                              : 'unbind_shopify_button')
                          .replaceFirst(
                          '{0}', s.shopifyUser?.externalUsername ?? ''),
                      minHeight: 45,
                      minWidget: double.infinity)),
        ]),
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) => a.showWechatUnbindConfirmation != b.showWechatUnbindConfirmation,
          builder: (ctx, s) => Visibility(
            visible: s.showWechatUnbindConfirmation,
            child: unbindWeChatConfirmation(),
          ),
        ),
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) => a.showBindShopifyStep != b.showBindShopifyStep,
          builder: (ctx, s) => Visibility(
            visible: s.showBindShopifyStep == 1,
            child: bindShopifyStep1(),
          ),
        ),
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) => a.showBindShopifyStep != b.showBindShopifyStep,
          builder: (ctx, s) => Visibility(
            visible: s.showBindShopifyStep == 2,
            child: bindShopifyStep2(),
          ),
        ),
      ]),
    );
  }

  String _validUsername(BuildContext context, String value) {
    String res = Reg.isEmpty(value);
    if (res != null) {
      return FlutterI18n.translate(context, res);
    }

    return null;
  }

  String _validEmail(BuildContext context, String value) {
    String res = Reg.isEmpty(value);
    if (res != null) return FlutterI18n.translate(context, res);

    res = Reg.isEmail(value);
    if (res != null) {
      return FlutterI18n.translate(context, res);
    }

    return null;
  }
}
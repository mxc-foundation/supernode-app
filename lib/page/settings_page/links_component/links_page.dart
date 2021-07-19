import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksPage extends StatelessWidget {
  Widget _item(BuildContext context,
      {String name = '', Function onTap, Widget leading}) {
    return ListTile(
      title: Text(name, style: FontTheme.of(context).big()),
      onTap: onTap,
      leading: leading,
    );
  }

  void _showWeChatDialog(BuildContext context) {
  showInfoDialog(
    context,
    IosStyleBottomDialog2(
      padding: EdgeInsets.only(top: 10, bottom: 30),
      builder: (ctx) => Container(
        alignment: Alignment.center,
        margin: kRoundRow2020,
        child: Image.asset(
          AppImages.weChatQRCode
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return pageFrame(
      context: context,
      padding: EdgeInsets.zero,
      children: [
        pageNavBar(FlutterI18n.translate(context, 'connect_with_us'),
            padding: const EdgeInsets.all(20),
            onTap: () => Navigator.of(context).pop()),
        Divider(),
        _item(
          context,
          name: FlutterI18n.translate(context, 'join_us_telegram'),
          onTap: () => launch('https://t.me/mxcfoundation'),
          leading: FaIcon(
            FontAwesomeIcons.telegramPlane,
            color: ColorsTheme.of(context).mxcBlue,
            size: 28,
          ),
        ),
        Divider(),
        _item(
          context,
          name: FlutterI18n.translate(context, 'join_us_wechat'),
          onTap: () =>
              _showWeChatDialog(context),
          leading: Image.asset(
            AppImages.weChat,
            color: ColorsTheme.of(context).mxcBlue,
          ),
        ),
        Divider(),
        _item(
          context,
          name: FlutterI18n.translate(context, 'join_us_twitter'),
          onTap: () => launch('https://twitter.com/MXCfoundation'),
          leading: FaIcon(
            FontAwesomeIcons.twitter,
            color: ColorsTheme.of(context).mxcBlue,
            size: 28,
          ),
        ),
        Divider(),
        _item(
          context,
          name: FlutterI18n.translate(context, 'join_us_discord'),
          onTap: () => launch('https://mxc.news/mxcdiscord'),
          leading: FaIcon(
            FontAwesomeIcons.discord,
            color: ColorsTheme.of(context).mxcBlue,
            size: 28,
          ),
        ),
      ],
    );
  }
}

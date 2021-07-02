import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/subtitle.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/components/update_dialog.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        pageFrame(
          context: context,
          padding: EdgeInsets.zero,
          children: [
            pageNavBar(
              FlutterI18n.translate(context, 'about'),
              padding: const EdgeInsets.all(20),
              onTap: () => Navigator.of(context).pop(),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 30, bottom: 50),
              child: Image.asset(AppImages.splashLogo, height: 100),
            ),
            Divider(),
            listItem(
              FlutterI18n.translate(context, 'impressum'),
              onTap: () => Tools.launchURL(Sys.impressum),
            ),
            Divider(),
            listItem(
              FlutterI18n.translate(context, 'privacy_policy'),
              onTap: () => Tools.launchURL(Sys.privacyPolicy),
            ),
            Divider(),
            listItem(
              FlutterI18n.translate(context, 'version'),
              onTap: () =>
                  Updater.instance.updateDialog(context).then((isLatest) {
                if (!isLatest)
                  tip(FlutterI18n.translate(context, 'tip_latest_version'),
                      success: true);
              }),
              trailing: Container(
                padding: kInnerRowRight10,
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (a, b) => a.info != b.info,
                  builder: (ctx, s) => Text(
                    s.info?.version == null
                        ? FlutterI18n.translate(context, 'loading')
                        : '${s.info.version} (${s.info.buildNumber})',
                    style: kMiddleFontOfGrey,
                  ),
                ),
              ),
            ),
            Divider(),
            listItem(
              FlutterI18n.translate(context, 'mxversion'),
              trailing: Container(
                padding: kInnerRowRight10,
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (a, b) => a.mxVersion != b.mxVersion,
                  builder: (ctx, s) => Text(
                    s.mxVersion == null
                        ? FlutterI18n.translate(context, 'loading')
                        : s.mxVersion,
                    style: kMiddleFontOfGrey,
                  ),
                ),
              ),
            ),
            Divider(),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 30,
          child: Center(
              child: BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.copyrightYear != b.copyrightYear,
            builder: (ctx, s) => subtitle(
              '© ${s.copyrightYear} ${FlutterI18n.translate(context, 'foundation')}. ${FlutterI18n.translate(context, 'all_rights')}',
            ),
          )),
        )
      ],
    );
  }
}

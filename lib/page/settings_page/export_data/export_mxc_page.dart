import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'export_mxc_per_year_page.dart';

class ExportMxcPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(
        context: context,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          PageNavBar.settings(
            text: FlutterI18n.translate(context, 'export_financial_data'),
          ),
          listItem(FlutterI18n.translate(context, 'select_year_to_export'),
              trailing: SizedBox(), onTap: () => ''),
          Divider(),
          ...yearsList(context)
        ]);
  }

  List<Widget> yearsList(BuildContext context) {
    final List<Widget> yearsList = [];
    for (int year = DateTime.now().year; year >= 2020; year--) {
      yearsList.add(listItem('$year',
          key: Key('year_$year'),
          onTap: () => Navigator.pushReplacement(
              context, routeWidget(ExportMxcPreYearPage(year)))));
      yearsList.add(Divider());
    }
    return yearsList;
  }
}

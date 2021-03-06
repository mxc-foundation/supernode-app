import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/buttons/secondary_shadow_button.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

typedef DateChangeCallback = String Function(String value);

class DateRangePicker extends StatelessWidget {
  final String firstTime;
  final String secondTime;
  final String thirdText;
  final DateChangeCallback firstTimeOnTap;
  final DateChangeCallback secondTimeOnTap;
  final VoidCallback onSearch;

  const DateRangePicker({
    Key key,
    this.firstTime,
    this.firstTimeOnTap,
    this.secondTimeOnTap,
    this.secondTime,
    this.thirdText,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        SecondaryShadowButton(
          color: ColorsTheme.of(context).secondaryBackground,
          buttonTitle: firstTime ?? '',
          icon: Icons.date_range,
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: new DateTime.now(),
                    firstDate: new DateTime(2000),
                    lastDate: new DateTime.now())
                .then((DateTime value) {
              if (value != null) {
                firstTimeOnTap(TimeUtil.getDatetime(value, type: 'date'));
              }
            });
          },
        ),
        Container(
          padding: kRoundRow5,
          child: Text('~'),
        ),
        SecondaryShadowButton(
          color: ColorsTheme.of(context).secondaryBackground,
          buttonTitle: secondTime ?? '',
          icon: Icons.date_range,
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: new DateTime.now(),
                    firstDate: firstTime != null
                        ? DateTime.parse(firstTime)
                        : new DateTime(2000),
                    lastDate: new DateTime.now())
                .then((DateTime value) {
              if (value != null) {
                secondTimeOnTap(TimeUtil.getDatetime(value, type: 'date'));
              }
            });
          },
        ),
        Spacer(),
        GestureDetector(
            child: Text(
              thirdText ?? '',
              style: FontTheme.of(context).middle.secondary.underline(),
            ),
            onTap: onSearch)
      ]),
    );
  }
}

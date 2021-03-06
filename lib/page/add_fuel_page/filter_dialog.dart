import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

enum FuelFilter {
  fuelLowToHigh,
  fuelHighToLow,
  healthScoreHightToLow,
  healthScoreLowToHigh,
}

Widget _dialogTile(
  BuildContext context,
  String title,
  FuelFilter filter, {
  bool checked = false,
}) =>
    Container(
      height: 60,
      alignment: Alignment.center,
      child: ListTile(
        title: Text(title),
        onTap: () {
          Navigator.of(context).pop(filter);
        },
        trailing: Icon(
          Icons.check,
          color: checked
              ? ColorsTheme.of(context).minerHealthRed
              : ColorsTheme.of(context).textLabel,
        ),
      ),
    );

IosStyleBottomDialog2 filterDialog() {
  return IosStyleBottomDialog2(
    closeOnTap: false,
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    builder: (context) => Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: Text(
            'Sort Miners',
            style: FontTheme.of(context).big(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        _dialogTile(context, 'Fuel Low to High', FuelFilter.fuelLowToHigh),
        _dialogTile(context, 'Fuel High to Low', FuelFilter.fuelHighToLow),
        _dialogTile(
          context,
          'Health Score Low to High',
          FuelFilter.healthScoreLowToHigh,
          checked: true,
        ),
        _dialogTile(
          context,
          'Health Score Hight to Low',
          FuelFilter.healthScoreHightToLow,
        ),
        SizedBox(height: 30),
      ],
    ),
  );
}

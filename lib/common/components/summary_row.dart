import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class SummaryRow extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String number;
  final String price;
  final bool loading;

  const SummaryRow({
    Key key,
    this.image = '',
    this.title = '',
    this.subtitle = '',
    this.number = '',
    this.price = '',
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var temp = price.split('(');
    String mxcPrice;
    String usdPrice;
    if (temp.length == 1) {
      usdPrice = price;
      mxcPrice = '';
    } else {
      mxcPrice = temp[0].substring(0, temp[0].length - 1);
      print(mxcPrice);
      usdPrice = temp[1].substring(0, temp[1].length - 1);
    }

    return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppImages.blueCircle,
                  fit: BoxFit.none,
                  color: lightBlue,
                ),
                Image.asset(
                  image,
                  fit: BoxFit.none,
                )
              ],
            ),
          ),
          Expanded(
            child:
            Column(children: [
              TitleDetailRow(
                loading: loading,
                name: title,
                value: number,
                token: '',
              ),
              TitleDetailRow(
                loading: loading,
                name: subtitle,
                value: usdPrice,
                token: '',
              ),
            ],),
          )
        ]
    );
  }
}

class TokenSummaryRow extends StatelessWidget {
  final String image;
  final String name;
  final String balance;
  final bool loading;

  const TokenSummaryRow({
    Key key,
    this.image = '',
    this.name = '',
    this.balance = '',
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
              child: Image.asset(
                image,
                fit: BoxFit.none,
              )
          ),
          Expanded(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(name, style: kBigBoldFontOfBlack)),
              TitleDetailRow(
                loading: loading,
                name: FlutterI18n.translate(context, 'balance'),
                value: balance,
                token: name,
              ),
            ]),
          )
        ]
    );
  }
}
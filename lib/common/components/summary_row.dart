import 'package:flutter/material.dart';
import 'package:supernodeapp/common/configs/images.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget summaryRow(
    {String image = '',
    String title = '',
    String subtitle = '',
    String number = '',
    String price = ''}) {
  var temp = price.split('(');
  String mxcPrice = temp[0].substring(0, temp[0].length - 1);
  print(mxcPrice);
  String usdPrice = temp[1].substring(0, temp[1].length - 1);

  return ListTile(
    leading: Stack(alignment: Alignment.center, children: [
      Image.asset(
        AppImages.blueCircle,
        fit: BoxFit.none,
        color: lightBlue,
      ),
      Image.asset(
        image,
        fit: BoxFit.none,
      )
    ]),
    title: Text(
      title,
      style: kMiddleFontOfBlack,
    ),
    subtitle: Text(
      number,
      style: kBigFontOfBlue,
    ),
    trailing: Container(
      margin: kOuterRowTop10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            subtitle,
            style: kSmallFontOfGrey,
          ),
          Text(
            '≈ ' + usdPrice,
            style: kMiddleFontOfBlack,
          )
        ],
      ),
    ),
  );
}

// return Container(
//     padding: EdgeInsets.all(10),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Stack(alignment: Alignment.center, children: [
//               Image.asset(
//                 AppImages.blueCircle,
//                 fit: BoxFit.none,
//                 color: lightBlue,
//               ),
//               Image.asset(
//                 image,
//                 fit: BoxFit.none,
//               )
//             ]),
//             SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   title,
//                   style: kMiddleFontOfBlack,
//                 ),
//                 Text(
//                   number,
//                   style: kBigFontOfBlue,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         Container(
//           margin: kOuterRowTop10,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               Text(
//                 subtitle,
//                 style: kSmallFontOfGrey,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   // Text(
//                   //   mxcPrice,
//                   //   style: kMiddleFontOfBlack,
//                   // ),
//                   Text(
//                     '≈ ' + usdPrice,
//                     style: kMiddleFontOfBlack,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         )
//       ],
//     ));

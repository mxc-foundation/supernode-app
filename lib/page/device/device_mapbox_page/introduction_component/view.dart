import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    IntroductionState state, Dispatch dispatch, ViewService viewService) {
  return PageView(
    children: <Widget>[
      _buildPage(pageBody:_buildFirstBody()),
      _buildPage(pageBody:_buildSecondBody()),
      _buildPage(pageBody:_buildThirdBody()),
    ],
  );
}

Widget _buildFirstBody() {
  return Column(
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: Text(
          'Congratulation!',
          style: kVeryBigFontOfBlack,
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Text(
              'You successfully connected your device. ',
              style: kBigFontOfGrey,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Now it is time to travel around your region to test the signals for better tracking results. Leave your footprints!',
                style: kBigFontOfGrey,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      Container(
        width: double.infinity,
        child: Image.asset(
          'assets/images/device/itr_1.png',
          fit: BoxFit.fitWidth,
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 10,bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Strong Signal', style: kSmallFontOfGrey),
            Text('Weak Signal', style: kSmallFontOfGrey),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        child: Image.asset(
          'assets/images/device/progress.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    ],
  );
}

Widget _buildSecondBody() {
  return Column(
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: Text(
          'Set Borders',
          style: kVeryBigFontOfBlack,
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child:Text(
          'Oracle is an IoT Data sharing device. In order to earn MXC token you will need to fill your details below. If you do not wish to earn MXC token you can skip this step.',
          style: kBigFontOfGrey,
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 20),
        width: double.infinity,
        child: Image.asset(
          'assets/images/device/itr_2.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    ],
  );
}
Widget _buildThirdBody() {
  return Column(
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: Text(
          'Your Data Matters',
          style: kVeryBigFontOfBlack,
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Text(
              'You successfully connected your device. ',
              style: kBigFontOfGrey,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Now it is time to travel around your region to test the signals for better tracking results. Leave your footprints!',
                style: kBigFontOfGrey,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      Image.asset(
        'assets/images/device/itr_1.png',
        fit: BoxFit.fitWidth,
      ),
      Container(
        padding: EdgeInsets.only(top: 10,bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Strong Signal', style: kSmallFontOfGrey),
            Text('Weak Signal', style: kSmallFontOfGrey),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        child: Image.asset(
          'assets/images/device/progress.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    ],
  );
}

Widget _buildPage({Widget pageBody}){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: Stack(
      children: <Widget>[
        panelFrame(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                pageNavBar(
                  'MXC Oracle',
                  padding: EdgeInsets.symmetric(vertical: 20),
                  hideClose: true,
                ),
                Container(child: pageBody),

              ],
            ),
          ),
        ),
        Positioned(
          bottom: 52.5,
          left: 0,
          right: 0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(28, 20, 120, 1),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(235, 239, 242, 1),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(235, 239, 242, 1),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

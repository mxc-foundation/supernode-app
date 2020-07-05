import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_button.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/action.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/introduction_component/action.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

const bottomHeight = 62.5;

Widget buildView(
    IntroductionState state, Dispatch dispatch, ViewService viewService) {
  MediaQueryData screenData;

  var _ctx = viewService.context;
  void initScreenData(BuildContext context) {
    if (screenData == null) {
      screenData = MediaQuery.of(context);
    }
  }

  Widget _buildButtonHeight() {
    return SizedBox(
        height: bottomHeight + 30 + (screenData?.padding?.bottom ?? 0));
  }

  Widget _buildIndicatorPoint({bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? Color.fromRGBO(28, 20, 120, 1)
            : Color.fromRGBO(235, 239, 242, 1),
      ),
    );
  }

  Widget _buildIndicator(int selectIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: _buildIndicatorPoint(isSelected: selectIndex == 0),
          onTap: () {
            state.pageController.jumpToPage(0);
          },
        ),
        SizedBox(width: 20),
        InkWell(
          child: _buildIndicatorPoint(isSelected: selectIndex == 1),
          onTap: () {
            state.pageController.jumpToPage(1);
          },
        ),
        SizedBox(width: 20),
        InkWell(
          child: _buildIndicatorPoint(isSelected: selectIndex == 2),
          onTap: () {
            println(2);
            state.pageController.jumpToPage(2);
          },
        ),
      ],
    );
  }

  Widget _buildRadioListTile(
      {String value, String groupValue, ValueChanged onChanged}) {
    return Row(
      children: <Widget>[
        Radio<String>(
          activeColor: Colors.black,
          value: value ?? "",
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(
          value ?? "",
          style: kMiddleFontOfGrey,
        ),
      ],
    );
  }

  Widget _buildFirstBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              FlutterI18n.translate(_ctx, 'congratulation') + "!",
              style: kVeryBigFontOfBlack,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Text(
                  FlutterI18n.translate(_ctx, 'connected_device_success'),
                  textAlign: TextAlign.center,
                  style: kBigFontOfGrey,
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
            padding: EdgeInsets.only(top: 10, bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(FlutterI18n.translate(_ctx, 'strong_signal'),
                    style: kSmallFontOfGrey),
                Text(FlutterI18n.translate(_ctx, 'weak_signal'),
                    style: kSmallFontOfGrey),
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
      ),
    );
  }

  Widget _buildSecondBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              FlutterI18n.translate(_ctx, 'set_borders'),
              style: kVeryBigFontOfBlack,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              FlutterI18n.translate(_ctx, 'set_borders_desc'),
              textAlign: TextAlign.center,
              style: kBigFontOfGrey,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            width: double.infinity,
            child: Image.asset(
              'assets/images/device/itr_2.png',
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThirdBody() {
    return ListView(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Text(
            FlutterI18n.translate(_ctx, 'your_data_matters'),
            style: kVeryBigFontOfBlack,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                 FlutterI18n.translate(_ctx, 'oracle_desc'),
                  textAlign: TextAlign.center,
                  style: kBigFontOfGrey,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.only(top: 30),
              child: Text(
                FlutterI18n.translate(_ctx,'device_who_use'),
                style: kBigFontOfBlack,
              ),
            ),
            _buildRadioListTile(
              value: FlutterI18n.translate(_ctx, 'me'),
              groupValue: state.userGroupValue,
              onChanged: (value) =>
                  dispatch(IntroductionActionCreator.onChangeRadio(value)),
            ),
            _buildRadioListTile(
              value: FlutterI18n.translate(_ctx, 'family_member'),
              groupValue: state.userGroupValue,
              onChanged: (value) =>
                  dispatch(IntroductionActionCreator.onChangeRadio(value)),
            ),
            _buildRadioListTile(
              value: FlutterI18n.translate(_ctx, 'for_my_pet'),
              groupValue: state.userGroupValue,
              onChanged: (value) =>
                  dispatch(IntroductionActionCreator.onChangeRadio(value)),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.only(top: 10),
              child: Text(
                FlutterI18n.translate(_ctx,'user_gender'),
                style: kBigFontOfBlack,
              ),
            ),
            Row(
              children: <Widget>[
                _buildRadioListTile(
                  value: FlutterI18n.translate(_ctx, 'male'),
                  groupValue: state.genderGroupValue,
                  onChanged: (value) => dispatch(
                      IntroductionActionCreator.onChangeGenderRadio(value)),
                ),
                _buildRadioListTile(
                  value: FlutterI18n.translate(_ctx, 'female'),
                  groupValue: state.genderGroupValue,
                  onChanged: (value) => dispatch(
                      IntroductionActionCreator.onChangeGenderRadio(value)),
                ),
                _buildRadioListTile(
                  value: FlutterI18n.translate(_ctx, 'non-binary'),
                  groupValue: state.genderGroupValue,
                  onChanged: (value) => dispatch(
                      IntroductionActionCreator.onChangeGenderRadio(value)),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: textfieldWithButton(
              readOnly: true,
              inputLabel: FlutterI18n.translate(_ctx, 'user_age'),
              isDivider: false,
              icon: Icons.expand_more,
              controller: state.ageController,
              onTap: () {
                dispatch(IntroductionActionCreator.onAgePicker());
              }),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PrimaryButton(
                minHeight: 35,
                padding: EdgeInsets.symmetric(vertical: 5),
                buttonTitle: FlutterI18n.translate(_ctx, 'save'),
                bgColor: Color.fromRGBO(28, 20, 120, 1),
                onTap: () {
                  dispatch(
                      DeviceMapBoxActionCreator.introductionVisible(false));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPage(
      {Widget pageBody, int selectIndex = 0, bool showSkip = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: <Widget>[
          panelFrame(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  pageNavBar(
                    FlutterI18n.translate(_ctx, 'MXC_oracle'),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    actionWidget: showSkip
                        ? InkWell(
                            onTap: () {
                              dispatch(
                                  DeviceMapBoxActionCreator.introductionVisible(
                                      false));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(FlutterI18n.translate(_ctx, 'skip'),
                                    style: kBigFontOfBlack),
                                Icon(Icons.arrow_forward_ios, size: 24),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ),
                  Expanded(child: pageBody),
                  _buildButtonHeight(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: bottomHeight + (screenData?.padding?.bottom ?? 0),
            left: 0,
            right: 0,
            child: Container(
              child: _buildIndicator(selectIndex),
            ),
          )
        ],
      ),
    );
  }

  initScreenData(_ctx);
  return PageView(
    controller: state.pageController,
    children: <Widget>[
      _buildPage(
        pageBody: _buildFirstBody(),
        selectIndex: 0,
      ),
      _buildPage(
        pageBody: _buildSecondBody(),
        selectIndex: 1,
      ),
      _buildPage(
        showSkip: true,
        pageBody: _buildThirdBody(),
        selectIndex: 2,
      ),
    ],
  );
}

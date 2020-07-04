import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/device/bottom_nav_tab.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/page/drag_page.dart';
import 'package:supernodeapp/common/components/widgets/scaffold_widget.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DeviceMapBoxState state, Dispatch dispatch, ViewService viewService) {
  return DragPage(
    key: state.dragPageState,
    backChild: ScaffoldWidget(
      body: Stack(
        children: <Widget>[
          MapBoxWidget(
            config: state.mapCtl,
            userLocationSwitch: true,
            isFullScreen: true,
          ),
          state.showIntroduction
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                )
              : SizedBox(),
          state.showIntroduction
              ? Positioned(
                  bottom: 0,
                  top: 80,
                  left: 0,
                  right: 0,
                  child: viewService.buildComponent('introduction'),
                )
              : SizedBox(),
          state.showSetBorderPrompt
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: viewService.buildComponent('borderPrompt'),
                )
              : SizedBox(),
        ],
      ),
    ),
    frontWidget: _buildFrontWidget(state, dispatch, viewService),
    showFrontWidget: state.showDragFrontWidget,
  );
}

Widget _buildFrontWidget(
    DeviceMapBoxState state, Dispatch dispatch, ViewService viewService) {
  Widget nextPage = SizedBox();
    var tabViewModel = [
      BottomNavTabViewModel(
          title: 'Discover',
          selectImageUrl: 'assets/images/device/map.png',
          imageUrl: 'assets/images/device/map_bg.png',
          onTap: () {
            state.bottomPageController.jumpToPage(0);
            dispatch(DeviceMapBoxActionCreator.changeBottomTab(0));
          }),
      BottomNavTabViewModel(
          title: 'Footprints',
          selectImageUrl: 'assets/images/device/signal.png',
          imageUrl: 'assets/images/device/signal_bg.png',
          onTap: () {
            state.bottomPageController.jumpToPage(1);
            dispatch(DeviceMapBoxActionCreator.changeBottomTab(1));
          }),
      BottomNavTabViewModel(
          title: 'Notification',
          selectImageUrl: 'assets/images/device/notification.png',
          imageUrl: 'assets/images/device/notification_bg.png',
          onTap: () {
            state.bottomPageController.jumpToPage(2);
            dispatch(DeviceMapBoxActionCreator.changeBottomTab(2));
          }),
    ];

  switch (state.showTabDetailName) {
    case TabDetailPageEnum.Discovery:
      nextPage = _buildPage(
        appBar: _buildAppBar(
          title: 'Gateway_01234',
          trackingWidget: InkWell(
            onTap: () {
              dispatch(DeviceMapBoxActionCreator.changeTabDetailName(null));
            },
            child: Icon(
              Icons.close,
              size: 20,
            ),
          ),
        ),
        pageContent: viewService.buildComponent('discoverBorder'),
      );
      break;
    case TabDetailPageEnum.Footprints:
      nextPage = _buildPage(
        appBar: _buildAppBar(
          title: '2020-05-22 09:39:12 14km -135dBm',
          trackingWidget: InkWell(
            onTap: () {
              dispatch(DeviceMapBoxActionCreator.changeTabDetailName(null));
            },
            child: Icon(
              Icons.close,
              size: 20,
            ),
          ),
        ),
        pageContent: viewService.buildComponent(
          'footPrintsLocation',
        ),
      );
      break;

    case TabDetailPageEnum.Notification:
      nextPage = _buildPage(
        appBar: _buildAppBar(
          title: 'Out of Border Notification',
          trackingWidget: InkWell(
            onTap: () {
              dispatch(DeviceMapBoxActionCreator.changeTabDetailName(null));
            },
            child: Icon(
              Icons.close,
              size: 20,
            ),
          ),
        ),
        pageContent: viewService.buildComponent('notificationOut'),
      );
      break;
  }
  return  Stack(
    children: <Widget>[
      Opacity(
        opacity: state.showTabDetailName==null?1:0,
        child: Stack(
          children: <Widget>[
            PageView(
              controller: state.bottomPageController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                _buildPage(
                  appBar: _buildAppBar(title: 'Discovery'),
                  pageContent: viewService.buildComponent('discover'),
                ),
                _buildPage(
                  appBar: _buildAppBar(title: 'Footprints'),
                  pageContent: viewService.buildComponent('footprints'),
                ),
                _buildPage(
                  appBar: _buildAppBar(title: 'Notification'),
                  pageContent: viewService.buildComponent('notification'),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavTab(
                selectIndex: state.selectTabIndex,
                viewModel: tabViewModel,
              ),
            )
          ],
        ),
      ),
      nextPage,
    ],
  );
}

Widget _buildAppBar({String title, Widget trackingWidget}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.only(top: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: boxShadowColor,
          offset: Offset(0, 0),
          blurRadius: 3.0,
        )
      ],
    ),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 21.5, horizontal: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title ?? "",
              style: kBigFontOfBlack,
            ),
          ),
          trackingWidget != null ? trackingWidget : SizedBox(),
        ],
      ),
    ),
  );
}

Widget _buildPage({Widget appBar, Widget pageContent}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        appBar == null ? SizedBox() : appBar,
        pageContent == null ? SizedBox() : Expanded(child: pageContent),
        SizedBox(height: 82.5),
      ],
    ),
  );
}

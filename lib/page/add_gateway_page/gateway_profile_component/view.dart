import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:supernodeapp/common/components/map.dart';
import 'package:supernodeapp/common/components/page/introduction.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/text_field/row_label.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_button.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/configs/images.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GatewayProfileState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  TapGestureRecognizer _gIdTapRecognizer =    TapGestureRecognizer()
    ..onTap = () => dispatch(GatewayProfileActionCreator.selectIdType());

  return pageFrame(
    context: viewService.context,
    children: [
      pageNavBar(
        FlutterI18n.translate(_ctx,'gateway_profile'),
        onTap: () => Navigator.pop(viewService.context)
      ),
      introduction(
        '${FlutterI18n.translate(_ctx,'serial_number')}: ${state.serialNumber}'
      ),
      Form(
        key: state.formKey,
        child: Column(
          children: <Widget>[
            textfieldWithButton(
              readOnly: true,
              inputLabel: FlutterI18n.translate(_ctx,'network_server'),
              isDivider: false,
              icon: Icons.expand_more,
              controller: state.networkCtl,
              onTap: () => dispatch(GatewayProfileActionCreator.onNetworkServerPicker())
            ),
            introduction(
              FlutterI18n.translate(_ctx,'network_server_tip'),
              top: 5,
              right: 0
            ),
            Visibility(
              visible: state.networkServerID.isNotEmpty,
              child: textfieldWithButton(
                readOnly: true,
                inputLabel: FlutterI18n.translate(_ctx,'smb_gateway_profile'),
                isDivider: false,
                icon: Icons.expand_more,
                controller: state.gatewayProfileCtl,
                onTap: () => dispatch(GatewayProfileActionCreator.onGatewayProfilePicker())
              ),
            ),
            Visibility(
              visible: state.networkServerID.isNotEmpty,
              child: introduction(
                FlutterI18n.translate(_ctx,'gateway_profile_tip'),
                top: 5,
                right: 0
              ),
            ),
            Container(
              margin: kOuterRowTop20,
              child: TextFieldWithTitle(
                readOnly: true,
                title: FlutterI18n.translate(_ctx,'gateway_name'),
                textInputAction: TextInputAction.next,
                validator: (value) => Reg.onNotEmpty(_ctx, value),
                controller: state.nameCtl,
              ),
            ),
            introduction(
              FlutterI18n.translate(_ctx,'reg_name'),
              top: 5,
              right: 0
            ),
            Container(
              margin: kOuterRowTop20,
              child: TextFieldWithTitle(
                title: FlutterI18n.translate(_ctx,'gateway_description'),
                textInputAction: TextInputAction.next,
                validator: (value) => Reg.onNotEmpty(_ctx, value),
                controller: state.descriptionCtl,
              ),
            ),
            Container(
              margin: kOuterRowTop20,
              child: TextFieldWithTitle(
                title: FlutterI18n.translate(_ctx,'gateway_id'),
                textInputAction: TextInputAction.next,
                validator: (value) => Reg.onNotEmpty(_ctx, value),
                controller: state.idCtl
              ),
            ),
            // textfieldWithButton(
            //   readOnly: true,
            //   inputLabel: FlutterI18n.translate(_ctx,'gateway_id'),
            //   buttonLabel: FlutterI18n.translate(_ctx,'random'),
            //   icon: Icons.cached,
            //   suffixTitleChild: Text.rich(
            //     TextSpan(
            //       children: [
            //         TextSpan(
            //           text: 'MSB',
            //           recognizer: _gIdTapRecognizer,
            //           style: state.isSelectIdType ?
            //             kMiddleFontOfBlue : kMiddleFontOfGrey
            //         ),
            //         TextSpan(
            //           text: ' / ',
            //         ),
            //         TextSpan(
            //           text: 'LSB',
            //           style: !state.isSelectIdType ?
            //             kMiddleFontOfBlue : kMiddleFontOfGrey,  
            //           recognizer: _gIdTapRecognizer
            //         ),
            //       ]
            //     )
            //   ),
            //   // initialValue: state.item.networkServerID,
            //   controller: state.idCtl,
            //   onTap: (){},
            // ),
            rowLabel(
              FlutterI18n.translate(_ctx,'discovery_enabled'),
              suffixChild: Switch(
                activeColor: buttonPrimaryColor,
                value: state.discoveryEnabled,
                onChanged: (value) {
                  dispatch(GatewayProfileActionCreator.discoveryEnabled());
                },
              )
            ),
            introduction(
              FlutterI18n.translate(_ctx,'discovery_enabled_tip'),
              top: 5,
              right: 0
            ),
            Container(
              margin: kOuterRowTop20,
              child: TextFieldWithTitle(
                title: FlutterI18n.translate(_ctx,'gateway_altitude'),
                textInputAction: TextInputAction.next,
                validator: (value) => Reg.onValidNumber(_ctx, value),
                controller: state.altitudeCtl,
              ),
            ),
            introduction(
              FlutterI18n.translate(_ctx,'gateway_altitude_tip'),
              top: 5,
              right: 0
            ),
            rowLabel(
              FlutterI18n.translate(_ctx,'gateway_location'),
              suffixChild: link(
                FlutterI18n.translate(_ctx,'set_location'),
                onTap: () => _changeMarker(state.mapCtl,state.location,dispatch)
              )
            ),
            MapWidget(
              context: _ctx,
              controller: state.mapCtl,
//              center: state.markerPoint,
              markers: [Marker(
                point: state.markerPoint,
                builder: (ctx) =>
                  Image.asset(AppImages.gateways),
              )],
              callback: (point) => dispatch(GatewayProfileActionCreator.addLocation(location: point)),
              onTap: (point) => _changeMarker(state.mapCtl,point,dispatch)
            ),
          ]
        )
      ),
      introduction(
        FlutterI18n.translate(_ctx,'drag_marker_tip'),
        top: 5,
        right: 0
      ),
      submitButton(
        FlutterI18n.translate(_ctx,'update'),
        onPressed: () => dispatch(GatewayProfileActionCreator.update())
      ),
    ]
  );
}

void _changeMarker(MapController mapCtl,LatLng point,dispatch){
  if(mapCtl.ready){
    mapCtl.move(point,mapCtl.zoom);
  }

  dispatch(GatewayProfileActionCreator.addLocation(location: point, type: 'marker'));
}
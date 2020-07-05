import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/permission_utils.dart';
import 'package:supernodeapp/configs/sys.dart';

class MapViewController {
  List<MapMarker> markers;
  MapboxMapController ctl;
  LatLng myLatLng;
  double zoom;

  bool _symbolsAdd = false;

  MapViewController({this.markers, this.zoom = 12});

  void onStyleLoadedInit() {
    if (!_symbolsAdd && (markers?.isNotEmpty ?? false)) {
      addSymbols(markers);
      _symbolsAdd = true;
    }
  }

  void onMapCreated(MapboxMapController controller) {
    this.ctl = controller;
  }

  Future<void> addSymbol(MapMarker marker) async {
    if (markers == null) markers = List<MapMarker>();
    var result = markers.where((MapMarker item) =>
        (item.point.latitude == marker.point.latitude) &&
        (item.point.longitude == item.point.longitude));
    if (result.isEmpty) {
      markers.add(marker);
    }
    await ctl?.addSymbol(SymbolOptions(
      iconImage: marker.image,
      geometry: marker.point,
      iconSize: marker?.size ?? 1,
    ));
  }
  Future<void> addCircle(MapMarker marker) async {
    if (markers == null) markers = List<MapMarker>();
    var result = markers.where((MapMarker item) =>
    (item.point.latitude == marker.point.latitude) &&
        (item.point.longitude == item.point.longitude));
    if (result.isEmpty) {
      markers.add(marker);
    }
    await ctl?.addSymbol(SymbolOptions(
      iconImage: marker.image,
      geometry: marker.point,
      iconSize: marker?.size ?? 1,
    ));
  }

  void addSymbols(List<MapMarker> markers) {
    for (MapMarker mark in markers ?? []) {
      addSymbol(mark);
    }
  }

  Future<void> moveToMyLatLng() async {
    if (myLatLng == null) myLatLng = await ctl.requestMyLocationLatLng();
    if (myLatLng != null)
      ctl.moveCamera(CameraUpdate.newLatLngZoom(myLatLng, zoom));
  }
}

class MapMarker {
  final LatLng point;
  final double size;
  final String image;
  final
  bool onMap = false;

  MapMarker({this.point, this.size, this.image});
}

class MapBoxWidget extends StatefulWidget {
  final bool isActionsTop;
  final bool isFullScreen;
  final bool userLocationSwitch;
  final VoidCallback zoomOutCallback;
  final ValueChanged<LatLng> onTap;

  // new field
  final Function clickLocation;
  final MapViewController config;

  // delete field
//  final BuildContext context;

  const MapBoxWidget({
    Key key,
    @required this.config,
    this.onTap,
    this.zoomOutCallback,
    this.clickLocation,
    this.userLocationSwitch = true,
    this.isFullScreen = false,
    this.isActionsTop = false,
  }) : super(key: key);

  @override
  _MapBoxWidgetState createState() => _MapBoxWidgetState();
}

class _MapBoxWidgetState extends State<MapBoxWidget> {
  bool _screenInit = false;
  bool _myLocationEnable = true;
  MediaQueryData _mediaData;

  MapViewController get config => widget.config;
  MyLocationTrackingMode _myLocationTrackingMode =
      MyLocationTrackingMode.Tracking;

  Future<void> _myLocationMove({bool state}) async {
    bool has = await PermissionUtil.getLocationPermission();
    setState(() {
      _myLocationEnable = has ? (state ?? true) : false;
    });
  }

  @override
  void initState() {
    super.initState();
//    _initLocation();
  }

  void _initLocation() {
    Future.delayed(new Duration(seconds: 1), () async {
      bool has = await PermissionUtil.getLocationPermission();
      if (mounted && has) {
        _changeModeToLocation();
      }
    });
  }

  void _screenQuery() {
    if (!_screenInit || _mediaData == null) {
      _mediaData = MediaQuery.of(context);
      _screenInit = true;
    }
  }

  //change TrackingMode to get the location
  // delay milliseconds: 200 change to original model
  void _changeModeToLocation() {
    setState(() {
      _myLocationTrackingMode =
          _myLocationTrackingMode = MyLocationTrackingMode.None;
    });
    Future.delayed(
        Duration(
          milliseconds: 200,
        ), () {
      setState(() {
        _myLocationTrackingMode =
            _myLocationTrackingMode = MyLocationTrackingMode.Tracking;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenQuery();
    return widget.isFullScreen
        ? Container(
            child: _buildMapView(),
            width: _mediaData.size.width,
            height: _mediaData.size.height,
          )
        : panelFrame(height: 263, child: _buildMapView());
  }

  Widget _buildMapView() {
    return Stack(
      children: <Widget>[
        MapboxMap(
          attributionButtonMargins: Point(-50, -50),
          initialCameraPosition: CameraPosition(
              target: LatLng(37.386, -122.083), zoom: config.zoom),
          myLocationEnabled: _myLocationEnable,
          myLocationRenderMode: MyLocationRenderMode.NORMAL,
          myLocationTrackingMode: _myLocationTrackingMode,
          styleString: Sys.mapTileStyle,
          compassEnabled: false,
          onMapClick: (point, coordinates) {
            widget.onTap(coordinates);
          },
          onMapCreated: (controller){
            config.onMapCreated(controller);
          },
          onStyleLoadedCallback: widget.config.onStyleLoadedInit,
          gestureRecognizers: !widget.isFullScreen
              ? <Factory<OneSequenceGestureRecognizer>>[
                  Factory<OneSequenceGestureRecognizer>(
                    () => ScaleGestureRecognizer(),
                  ),
                ].toSet()
              : null,
        ),
        _buildActionWidgets(),
      ],
    );
  }

  Widget _buildActionWidgets() {
    double topHeight;
    double bottomHeight;
    if (widget.isActionsTop || !widget.isFullScreen) {
      if (widget.isFullScreen) {
        topHeight = _mediaData.padding.top + 50;
      } else {
        topHeight = 20;
      }
      bottomHeight = null;
    } else {
      topHeight = null;
      bottomHeight = 40 + _mediaData.padding.bottom + 80 + 10;
    }
    return Positioned(
      top: topHeight,
      bottom: bottomHeight,
      right: 20,
      child: Column(
        children: <Widget>[
          _buildMyLocationIcon(),
          _buildMyLocationStateChange(),
          widget.isFullScreen ? _buildCloseIcon() : _buildZoomOutIcon(),
        ],
      ),
    );
  }

  Widget _buildMyLocationIcon() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
      ),
      child: IconButton(
        onPressed: () async {
          await _myLocationMove();
//            config.moveToMyLatLng();
          _changeModeToLocation();
        },
        icon: Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildZoomOutIcon() {
    if (widget.zoomOutCallback == null) return SizedBox();
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
      ),
      child: IconButton(
        onPressed: widget.zoomOutCallback,
        icon: Icon(
          Icons.zoom_out_map,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMyLocationStateChange() {
    if (!widget.userLocationSwitch) {
      return SizedBox();
    }
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
      ),
      child: IconButton(
        onPressed: () async {
          _myLocationMove(state: !_myLocationEnable);
        },
        icon: Icon(
          _myLocationEnable ? Icons.location_off : Icons.location_on,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCloseIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
      ),
      child: IconButton(
        onPressed: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }
}

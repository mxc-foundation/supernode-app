import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

class UserState implements Cloneable<UserState> {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();

  //profile
  String selectedSuperNode = '';
  String id = '';
  String username = '';
  String password = '';
  String token = '';
  bool isObscureText = true;
  bool isAdmin = false;
  bool isActive = false;
  String email = '';
  String note = '';

  List<OrganizationsState> organizations = [];

  //wallet
  double balance = 0;

  //stake
  double stakedAmount = 0;

  //gateways
  int gatewaysTotal = 0;
  double gatewaysRevenue = 0;
  double gatewaysUSDRevenue = 0;
  List<Marker> gatewaysLocations = [];

  //devices
  int devicesTotal = 0;
  double devicesRevenue = 0;
  double devicesUSDRevenue = 0;

  //map
  MapController mapCtl = MapController();
  StreamController<LatLng> markerlocationStream = StreamController();
  LatLng location;

  UserState();

  @override
  UserState clone() {
    return UserState()
      ..formKey = formKey
      ..usernameCtl = usernameCtl
      ..passwordCtl = passwordCtl
      ..isObscureText = isObscureText
      ..selectedSuperNode = selectedSuperNode
      ..id = id
      ..username = username
      ..password = password
      ..token = token
      ..isAdmin = isAdmin
      ..isActive = isActive
      ..email = email
      ..note = note
      ..organizations = organizations ?? []
      ..balance = balance
      ..stakedAmount = stakedAmount
      ..gatewaysTotal = gatewaysTotal
      ..gatewaysRevenue = gatewaysRevenue
      ..gatewaysUSDRevenue = gatewaysUSDRevenue
      ..devicesTotal = devicesTotal
      ..devicesRevenue = devicesRevenue
      ..devicesUSDRevenue = devicesUSDRevenue
      ..mapCtl = mapCtl
      ..markerlocationStream = markerlocationStream
      ..location = location
      ..gatewaysLocations = gatewaysLocations;
  }

  UserState.fromMap(Map map, {String type = 'local'}) {
    id = map[UserDao.id] as String;
    username = map[UserDao.username] as String;
    token = map[UserDao.token] as String;
    isAdmin = type == 'local'
        ? (map[UserDao.isAdmin] == 1 ? true : false)
        : (map[UserDao.isAdmin] as bool);
    isActive = type == 'local'
        ? (map[UserDao.isActive] == 1 ? true : false)
        : (map[UserDao.isActive] as bool);
    email = map[UserDao.email] as String;
    note = map[UserDao.note] as String;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      UserDao.id: id,
      UserDao.username: username,
      UserDao.token: token,
      UserDao.isAdmin: isAdmin,
      UserDao.isActive: isActive,
      UserDao.email: email,
      UserDao.note: note,
    };

    return map;
  }
}

UserState initState(Map<String, dynamic> args) {
  return UserState();
}

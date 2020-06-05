import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/user_component/state.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';
import 'package:latlong/latlong.dart';

enum HomeAction {
  relogin,
  loading,
  tabIndex,
  onProfile,
  profile,
  balance,
  mapbox,
  stakedAmount,
  gateways,
  onGateways,
  devices,
  gatewaysLocations,
  onOperate,
  onSettings,
  updateUsername,
  miningIncome,
  convertUSD,
  location,
}

class HomeActionCreator {
  static Action onReLogin() {
    return const Action(HomeAction.relogin);
  }

  static Action loading(bool toogle) {
    return Action(HomeAction.loading, payload: toogle);
  }

  static Action onProfile() {
    return const Action(HomeAction.onProfile);
  }

  static Action profile(UserState user, List<OrganizationsState> organizations) {
    return Action(HomeAction.profile, payload: {'user': user, 'organizations': organizations});
  }

  static Action updateUsername(Map data) {
    return Action(HomeAction.updateUsername, payload: data);
  }

  static Action balance(double data) {
    return Action(HomeAction.balance, payload: data);
  }

  static Action mapbox(){
    return const Action(HomeAction.mapbox);
  }

  static Action stakedAmount(double data) {
    return Action(HomeAction.stakedAmount, payload: data);
  }

  static Action miningIncome(double value) {
    return Action(HomeAction.miningIncome, payload: value);
  }

  static Action gateways(int total, double value, List list) {
    return Action(HomeAction.gateways, payload: {'total': total, 'value': value, 'list': list});
  }

  static Action onGateways() {
    return const Action(HomeAction.onGateways);
  }

  static Action gatewaysLocations(List data) {
    return Action(HomeAction.gatewaysLocations, payload: data);
  }

  static Action devices(int total, double value) {
    return Action(HomeAction.devices, payload: {'total': total, 'value': value});
  }

  static Action tabIndex(int index) {
    return Action(HomeAction.tabIndex, payload: index);
  }

  static Action onOperate(String act) {
    return Action(HomeAction.onOperate, payload: act);
  }

  static Action onSettings() {
    return const Action(HomeAction.onSettings);
  }

  static Action convertUSD(String type, value) {
    return Action(HomeAction.convertUSD, payload: {'type': type, 'value': value});
  }

  static Action onLocation(LatLng location){
    return Action(HomeAction.location, payload: location);
  }
}

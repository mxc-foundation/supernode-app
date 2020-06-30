import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class IntroductionState implements Cloneable<IntroductionState> {
  String userGroupValue = 'Me';
  String genderGroupValue = 'Male';
  PageController pageController = new PageController();

  @override
  IntroductionState clone() {
    return IntroductionState()
      ..userGroupValue = userGroupValue
      ..genderGroupValue = genderGroupValue
      ..pageController = pageController;
  }
}

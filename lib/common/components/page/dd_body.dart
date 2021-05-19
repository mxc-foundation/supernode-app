import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/spacing.dart';

class DDBody extends StatelessWidget {
  final Widget child;
  final bool resizeToAvoidBottomInset;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  const DDBody({
    Key key,
    @required this.child,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.centerDocked
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            margin: kOuterRowTop20,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(26, 0, 0, 0),
                  offset: Offset(0, 2),
                  blurRadius: 7,
                ),
              ],
            ),
            child: child
          )
        ),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }

}
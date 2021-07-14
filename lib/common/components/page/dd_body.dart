import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

class DDBody extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget child;
  final bool resizeToAvoidBottomInset;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  const DDBody(
      {Key key,
      @required this.child,
      this.appBar,
      this.resizeToAvoidBottomInset = true,
      this.floatingActionButton,
      this.floatingActionButtonLocation =
          FloatingActionButtonLocation.centerDocked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
          margin: kOuterRowTop70,
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
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: child)),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}

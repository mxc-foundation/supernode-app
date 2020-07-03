import 'package:flutter/material.dart';

const double minHeight = 110;
const double showHeight = 314;

class DragPage extends StatefulWidget {
  final Widget backChild;
  final Widget frontWidget;
  final bool showFrontWidget;

  const DragPage(
      {Key key,
      @required this.backChild,
      @required this.frontWidget,
      this.showFrontWidget = true})
      : super(key: key);

  @override
  DragPageState createState() => DragPageState();
}

class DragPageState extends State<DragPage> with TickerProviderStateMixin {
  double showHeightAnimationValue;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
  }

  void setInitHeight() {
    setState(() {
      if (showHeightAnimationValue != null) {
        _animationController.value = showHeightAnimationValue;
      }
    });

  }

  void _drag(DragUpdateDetails d, double screenHeight) {
    _animationController.value -= d.primaryDelta / (screenHeight - minHeight);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    showHeightAnimationValue = 1 -
        ((screenSize.height - showHeight) / (screenSize.height - minHeight));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                _animationController.value = 0;
              });
            },
            child: Container(
              child: widget.backChild,
            ),
          ),
          widget.showFrontWidget
              ? AnimatedBuilder(
                  animation: _animationController,
                  builder: (ctx, child) {
                    return Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      top: (1 - _animationController.value) *
                          (screenSize.height - minHeight),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          widget.frontWidget,
                          Positioned(
                            top: 0,
                            child: GestureDetector(
                              onVerticalDragUpdate: (DragUpdateDetails d) {
                                _drag(d, screenSize.height);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  height: 4,
                                  width: 42.4,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(152, 166, 173, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

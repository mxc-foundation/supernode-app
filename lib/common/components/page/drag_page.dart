import 'package:flutter/material.dart';

const double minHeight = 110;
const double middleHeight = 314;
enum HeightStatusEnum {
  min,
  middle,
  big,
}

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
  double _middleHeightAnimateValue;
  double _bigHeightAnimateValue;
  double _minHeightAnimateValue = 0;
  AnimationController _animationController;
  HeightStatusEnum _heightStatusEnum = HeightStatusEnum.middle;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void setMinHeight() {
    setState(() {
      if (_minHeightAnimateValue != null) {
        _heightStatusEnum = HeightStatusEnum.min;
        _animationController.value = _minHeightAnimateValue;
      }
    });
  }

  void setMiddleHeight() {
    setState(() {
      if (_middleHeightAnimateValue != null) {
        _heightStatusEnum = HeightStatusEnum.middle;
        _animationController.value = _middleHeightAnimateValue;
      }
    });
  }

  void _changeHeightStatus() {
    if (_heightStatusEnum == HeightStatusEnum.min) {
      if (_middleHeightAnimateValue != null) {
        setState(() {
          _heightStatusEnum = HeightStatusEnum.middle;
          _animationController.value = _middleHeightAnimateValue;
        });
      }
    } else if (_heightStatusEnum == HeightStatusEnum.middle) {
      if (_bigHeightAnimateValue != null) {
        setState(() {
          _heightStatusEnum = HeightStatusEnum.big;
          _animationController.value = _bigHeightAnimateValue;
        });
      }
    } else if (_heightStatusEnum == HeightStatusEnum.big) {
      if (_bigHeightAnimateValue != null) {
        setState(() {
          _heightStatusEnum = HeightStatusEnum.min;
          _animationController.value = _minHeightAnimateValue;
        });
      }
    }
  }

  void _drag(DragUpdateDetails d, double screenHeight) {
    _animationController.value -= d.primaryDelta / (screenHeight - minHeight);
  }

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context);
    var realMinHeight = minHeight + (screenData?.padding?.bottom ?? 0);
    var realMiddleHeight = middleHeight + (screenData?.padding?.bottom ?? 0);
    final screenSize = MediaQuery.of(context).size;
    _middleHeightAnimateValue = 1 -
        ((screenSize.height - realMiddleHeight) /
            (screenSize.height - realMinHeight));
    _bigHeightAnimateValue = 1 -
        ((screenSize.height - screenSize.height + 100) /
            (screenSize.height - realMinHeight));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: widget.backChild,
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
                          (screenSize.height - realMinHeight),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          widget.frontWidget,
                          Positioned(
                            top: 0,
                            child: GestureDetector(
                              onTap: () {
                                _changeHeightStatus();
                              },
                              onVerticalDragUpdate: (DragUpdateDetails d) {
                                _drag(d, screenSize.height);
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 10, left: 20, right: 20, bottom: 20),
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

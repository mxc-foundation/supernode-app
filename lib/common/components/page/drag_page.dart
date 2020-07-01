import 'package:flutter/material.dart';

class DragPage extends StatefulWidget {
  final Widget backChild;
  final Widget frontWidget;
  final double initHeight;

  const DragPage(
      {Key key,
      @required this.backChild,
      @required this.frontWidget,
      this.initHeight})
      : super(key: key);

  @override
  _DragPageState createState() => _DragPageState();
}

class _DragPageState extends State<DragPage> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));


  }

  void _drag(DragUpdateDetails d, double screenHeight) {
    _animationController.value -=
        d.primaryDelta / (screenHeight - widget.initHeight);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: widget.backChild,
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (ctx, child) {
              return Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                top: (1 - _animationController.value) *
                    (screenSize.height - widget.initHeight),
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
                              borderRadius: BorderRadius.all(Radius.circular(5)),
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
        ],
      ),
    );
  }
}

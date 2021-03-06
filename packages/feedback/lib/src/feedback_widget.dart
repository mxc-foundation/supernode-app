import 'dart:typed_data';

import 'package:feedback/src/better_feedback.dart';
import 'package:feedback/src/controls_column.dart';
import 'package:feedback/src/feedback_widget_content.dart';
import 'package:feedback/src/paint_on_background.dart';
import 'package:feedback/src/painter.dart';
import 'package:feedback/src/scale_and_clip.dart';
import 'package:feedback/src/screenshot.dart';
import 'package:feedback/src/translation.dart';
import 'package:flutter/material.dart';

typedef FeedbackButtonPress = void Function(BuildContext context);

class FeedbackWidget<T> extends StatefulWidget {
  const FeedbackWidget({
    Key key,
    @required this.translation,
    @required this.screenshot,
    this.backgroundColor,
    this.drawColors,
    this.formBuilder,
  })  : assert(translation != null),
        // if the user chooses to supply custom drawing colors,
        // make sure there is at least on color to draw with
        assert(
          // ignore: prefer_is_empty
          drawColors == null || (drawColors != null && drawColors.length > 0),
          'There must be at least one color to draw',
        ),
        super(key: key);

  final Color backgroundColor;
  final List<Color> drawColors;
  final FeedbackTranslation translation;
  final Uint8List screenshot;
  final FeedbackFormBuilder<T> formBuilder;

  @override
  FeedbackWidgetState createState() => FeedbackWidgetState<T>();
}

@visibleForTesting
class FeedbackWidgetState<T> extends State<FeedbackWidget<T>>
    with SingleTickerProviderStateMixin {
  PainterController painterController;
  ScreenshotController screenshotController = ScreenshotController();

  bool isNavigatingActive = false;
  AnimationController _controller;
  List<Color> drawColors;

  PainterController create() {
    final PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.drawColor = drawColors[0];
    return controller;
  }

  @override
  void initState() {
    super.initState();

    drawColors = widget.drawColors ??
        [
          Colors.black,
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.yellow,
        ];

    painterController = create();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Possible optimization:
    // If feedback is invisible just build widget.child
    // without the whole feedback foo.
    //if (!widget.isFeedbackVisible) {
    //  return widget.child;
    //}

    final scaleAnimation = Tween<double>(begin: 1, end: 0.65)
        .chain(CurveTween(curve: Curves.easeInSine))
        .animate(_controller);

    final animation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInSine))
        .animate(_controller);

    final controlsHorizontalAlignment = Tween<double>(begin: 1.4, end: .95)
        .chain(CurveTween(curve: Curves.easeInSine))
        .animate(_controller);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          color: widget.backgroundColor,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: ScaleAndClip(
                  scale: scaleAnimation.value,
                  alignmentProgress: animation.value,
                  child: Screenshot(
                    controller: screenshotController,
                    child: PaintOnChild(
                      controller: painterController,
                      isPaintingActive: true,
                      child: Image.memory(widget.screenshot),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(
                  controlsHorizontalAlignment.value,
                  -0.7,
                ),
                child: ControlsColumn(
                  activeColor: painterController.drawColor,
                  translation: widget.translation,
                  colors: drawColors,
                  onColorChanged: (color) {
                    setState(() {
                      painterController.drawColor = color;
                    });
                    _hideKeyboard(context);
                  },
                  onUndo: () {
                    painterController.undo();
                    _hideKeyboard(context);
                  },
                  onClearDrawing: () {
                    painterController.clear();
                    _hideKeyboard(context);
                  },
                  onCloseFeedback: () {
                    _hideKeyboard(context);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Positioned(
                key: const Key('feedback_user_input_fields'),
                left: 0,
                // Make sure the input field is always visible,
                // especially if the keyboard is shown
                bottom: MediaQuery.of(context).viewInsets.bottom,
                right: 0,
                child: Material(
                  type: MaterialType.transparency,
                  child: Builder(
                    builder: (innerContext) {
                      Future<void> fun(String text, [T params]) => sendFeedback(
                            innerContext,
                            screenshotController,
                            text,
                            params: params,
                          );
                      return widget.formBuilder != null
                          ? widget.formBuilder(fun)
                          : FeedbackWidgetForm(widget.translation, fun);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @visibleForTesting
  static Future<void> sendFeedback<T>(
    BuildContext context,
    ScreenshotController controller,
    String feedbackText, {
    Duration delay = const Duration(milliseconds: 200),
    bool showKeyboard = false,
    T params,
  }) async {
    if (!showKeyboard) {
      _hideKeyboard(context);
    }

    // Wait for the keyboard to be closed, and then proceed
    // to take a screenshot
    await Future<void>.delayed(delay);

    // Take high resolution screenshot
    final screenshot = await controller.capture(
      pixelRatio: 3,
      delay: const Duration(milliseconds: 0),
    );

    // Give it to the developer
    // to do something with it.
    Navigator.of(context).pop(FeedbackResponse<T>(
      feedbackText,
      screenshot,
      params,
    ));
  }

  static void _hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

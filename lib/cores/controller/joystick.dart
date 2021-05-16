import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'controller.dart';

enum MovingDirection {
  Forward,
  Backward,
  TopWard,
  DownWard,
}

class JoyStick extends StatefulWidget implements IControllerWidget {
  final double width;
  final Function(dynamic d) onChange;

  JoyStick({
    required this.width,
    required this.onChange,
  });

  @override
  State<StatefulWidget> createState() {
    return _JoyStickState();
  }

  @override
  void disable() {
    // TODO: implement disable
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void resume() {
    // TODO: implement resume
  }

  @override
  void start({required String playerId}) {
    // TODO: implement start
  }
}

class _JoyStickState extends State<JoyStick> {
  late bool updatingLoop;
  late double topDelta;
  late double leftDelta;

  @override
  void initState() {
    this.topDelta = widget.width / 2;
    this.leftDelta = widget.width / 2;

    super.initState();
  }

  onPanUpdate(DragUpdateDetails d) {
    double min = widget.width * 0.125;
    double max = widget.width - min;
    double ny = (d.localPosition.dy * 100) / widget.width > 100
        ? 100
        : (d.localPosition.dy * 100) / widget.width < 0
            ? 0
            : (d.localPosition.dy * 100) / widget.width;
    double nx = (d.localPosition.dx * 100) / widget.width > 100
        ? 100
        : (d.localPosition.dx * 100) / widget.width < 0
            ? 0
            : (d.localPosition.dx * 100) / widget.width;
    double newTopDelta = d.localPosition.dy > max
        ? max
        : d.localPosition.dy < min
            ? min
            : d.localPosition.dy;
    double newLeftDelta = d.localPosition.dx > max
        ? max
        : d.localPosition.dx < min
            ? min
            : d.localPosition.dx;

    if (ny < 50) {
      // this.position.yDirection = MovingDirection.DownWard;
    } else {
      // this.position.yDirection = MovingDirection.TopWard;
    }

    if (nx < 50) {
      // this.position.xDirection = MovingDirection.Backward;
    } else {
      // this.position.xDirection = MovingDirection.Forward;
    }

    // this.position.xAcceleration = (((nx - 50).abs() / 100) * 100) / 50;
    // this.position.yAcceleration = (((ny - 50).abs() / 100) * 100) / 50;
    widget.onChange(1);

    setState(() {
      this.topDelta = newTopDelta;
      this.leftDelta = newLeftDelta;
    });
  }

  onPanEnd(DragEndDetails _) {
    // this.position.xAcceleration = 0;
    // this.position.yAcceleration = 0;
    widget.onChange(0);

    setState(() {
      this.topDelta = widget.width / 2;
      this.leftDelta = widget.width / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onPanUpdate: onPanUpdate,
          onPanEnd: onPanEnd,
          child: Opacity(
            opacity: 0.25,
            child: Container(
              height: widget.width,
              width: widget.width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                image: DecorationImage(
                  image: Image.asset(
                          "assets/components/joystick/joystick_layout.png")
                      .image,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: this.topDelta - (widget.width * 0.125),
          left: this.leftDelta - (widget.width * 0.125),
          child: IgnorePointer(
            child: Container(
              height: widget.width * 0.25,
              width: widget.width * 0.25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white,
                    Color(0xFF808080),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

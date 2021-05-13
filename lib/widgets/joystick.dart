import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MovingDirection {
  Forward,
  Backward,
  TopWard,
  DownWard,
}

class IPosition {
  MovingDirection? xDirection;
  MovingDirection? yDirection;
  double? xAcceleration;
  double? yAcceleration;

  IPosition({
    this.xDirection,
    this.yDirection,
    this.xAcceleration,
    this.yAcceleration,
  }) {
    if (this.xDirection == null) {
      this.xDirection = MovingDirection.Forward;
    }
    if (this.yDirection == null) {
      this.xDirection = MovingDirection.TopWard;
    }
    if (this.xAcceleration == null) {
      this.xAcceleration = 0.0;
    }
    if (this.yAcceleration == null) {
      this.yAcceleration = 0.0;
    }
  }
}

class JoyStick extends StatefulWidget {
  final double width;
  final Function(IPosition position) onChange;

  JoyStick({
    required this.width,
    required this.onChange,
  });

  @override
  State<StatefulWidget> createState() {
    return _JoyStickState();
  }
}

class _JoyStickState extends State<JoyStick> {
  late IPosition position;
  late bool updatingLoop;
  late double topDelta;
  late double leftDelta;

  @override
  void initState() {
    this.position = IPosition(xAcceleration: 0, yAcceleration: 0);
    this.updatingLoop = false;
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
      this.position.yDirection = MovingDirection.DownWard;
    } else {
      this.position.yDirection = MovingDirection.TopWard;
    }

    if (nx < 50) {
      this.position.xDirection = MovingDirection.Backward;
    } else {
      this.position.xDirection = MovingDirection.Forward;
    }

    this.position.xAcceleration = (((nx - 50).abs() / 100) * 100) / 50;
    this.position.yAcceleration = (((ny - 50).abs() / 100) * 100) / 50;
    widget.onChange(this.position);

    setState(() {
      this.topDelta = newTopDelta;
      this.leftDelta = newLeftDelta;
    });
  }

  onPanEnd(DragEndDetails _) {
    this.position.xAcceleration = 0;
    this.position.yAcceleration = 0;
    widget.onChange(this.position);

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
                          "lib/assets/components/joystick/joystick_layout.png")
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

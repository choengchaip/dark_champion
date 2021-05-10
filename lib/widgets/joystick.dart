import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MovingDirection {
  Forward,
  Backward,
}

class IPosition {
  MovingDirection? direction;
  double? acceleration;

  IPosition({
    this.direction,
    this.acceleration,
  }) {
    if (this.direction == null) {
      this.direction = MovingDirection.Forward;
    }
    if (this.acceleration == null) {
      this.acceleration = 0.0;
    }
  }
}

class JoyStick extends StatefulWidget {
  final Function(IPosition position) onChange;

  JoyStick({
    required this.onChange,
  });

  @override
  State<StatefulWidget> createState() {
    return _JoyStickState();
  }
}

class _JoyStickState extends State<JoyStick> {
  late IPosition position;
  late double topDelta;
  late double leftDelta;

  @override
  void initState() {
    this.position = IPosition(acceleration: 0);
    this.topDelta = 50;
    this.leftDelta = 50;

    super.initState();
  }

  onPanUpdate(double x, double y) {
    double max = 50;
    MovingDirection direction =
        x < 50 ? MovingDirection.Backward : MovingDirection.Forward;
    double nx = x < 25
        ? 25
        : x > 125
            ? 125
            : x;
    double ny = y < 25
        ? 25
        : y > 125
            ? 125
            : y;
    double result = (50 - (nx - 25).abs()) * 100 / max;

    this.position.direction = direction;
    this.position.acceleration = result.abs() / 7500;
    widget.onChange(this.position);

    setState(() {
      this.leftDelta = nx - 25;
      this.topDelta = ny - 25;
    });
  }

  onPanReset() {
    this.position.acceleration = 0;
    widget.onChange(this.position);

    setState(() {
      this.topDelta = 50;
      this.leftDelta = 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onPanUpdate: (d) {
            this.onPanUpdate(d.localPosition.dx, d.localPosition.dy);
          },
          onPanEnd: (d) {
            this.onPanReset();
          },
          child: Container(
            height: 150,
            width: 150,
            color: Colors.transparent,
          ),
        ),
        IgnorePointer(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: this.topDelta,
          left: this.leftDelta,
          child: IgnorePointer(
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

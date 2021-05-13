import 'dart:async';
import 'package:dark_champion/configs/config.dart';
import 'package:dark_champion/cores/context.dart';
import 'package:dark_champion/widgets/joystick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  MapPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return _MapPageState();
  }
}

class IDelta {
  double x;
  double y;

  IDelta({
    required this.x,
    required this.y,
  });
}

class _MapPageState extends State<MapPage> {
  late IDelta delta;
  late StreamController<IDelta> deltaSC;
  late bool isUpdating;
  late bool testBool;
  late StreamController<bool> testBoolSC;
  late IPosition oldPosition;
  Timer? t;
  Timer? tt;

  @override
  void initState() {
    this.delta = IDelta(x: 50, y: 50);
    this.deltaSC = StreamController<IDelta>();
    this.isUpdating = false;

    this.testBool = false;
    this.testBoolSC = StreamController<bool>();

    this.deltaSC.add(this.delta);
    this.testBoolSC.add(this.testBool);

    this.oldPosition = IPosition(xDirection: MovingDirection.Forward, xAcceleration: 0);
    this.t = Timer.periodic(Duration(milliseconds: 1), (_) {
      if(this.oldPosition.yDirection == MovingDirection.TopWard) {
        this.delta.y += this.oldPosition.yAcceleration!;
      } else if (this.oldPosition.yDirection == MovingDirection.DownWard) {
        this.delta.y -= this.oldPosition.yAcceleration!;
      }
      if(this.oldPosition.xDirection == MovingDirection.Forward) {
        this.delta.x += this.oldPosition.xAcceleration!;
      } else if (this.oldPosition.xDirection == MovingDirection.Backward) {
        this.delta.x -= this.oldPosition.xAcceleration!;
      }

      this.deltaSC.add(this.delta);
    });
    this.tt = Timer.periodic(Duration(seconds: 1), (_) {
      this.testBool = !this.testBool;
      this.testBoolSC.add(this.testBool);
    });

    super.initState();
  }

  @override
  void dispose() {
    this.deltaSC.close();
    this.testBoolSC.close();
    this.t?.cancel();
    this.tt?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: Stack(
          children: [
            StreamBuilder<bool>(
              stream: this.testBoolSC.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                return AnimatedPositioned(
                  top: 16,
                  left: snapshot.data == true ? 32 : 200,
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                  ),
                  duration: Duration(
                    seconds: 1,
                  ),
                );
              },
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: JoyStick(
                width: 150,
                onChange: (p) {
                  this.oldPosition = p;
                },
              ),
            ),
            StreamBuilder<IDelta>(
              stream: this.deltaSC.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                return Positioned(
                  top: snapshot.data?.y,
                  left: snapshot.data?.x,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

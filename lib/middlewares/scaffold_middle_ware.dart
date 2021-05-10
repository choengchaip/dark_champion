import 'package:dark_champion/configs/config.dart';
import 'package:dark_champion/cores/context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScaffoldMiddleWare extends StatefulWidget {
  final IContext? context;
  final IConfig? config;
  final Widget child;

  ScaffoldMiddleWare({
    this.context,
    this.config,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return ScaffoldMiddleWareState();
  }
}

class ScaffoldMiddleWareState extends State<ScaffoldMiddleWare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }
}

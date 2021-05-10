import 'package:dark_champion/configs/config.dart';
import 'package:dark_champion/cores/context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralMiddleWare extends StatefulWidget {
  final IContext? context;
  final IConfig? config;
  final Widget child;

  GeneralMiddleWare({
    this.context,
    this.config,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return GeneralMiddleWareState();
  }
}

class GeneralMiddleWareState extends State<GeneralMiddleWare> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

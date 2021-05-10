import 'package:dark_champion/configs/config.dart';
import 'package:dark_champion/cores/context.dart';
import 'package:dark_champion/middlewares/scaffold_middle_ware.dart';
import 'package:dark_champion/pages/map_page.dart';
import 'package:dark_champion/styles/colors.dart';
import 'package:dark_champion/styles/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  LoginPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ScaffoldMiddleWare(
            child: MapPage(
              context: widget.context,
              config: widget.config,
            ),
          );
        }));
      },
      child: Container(
        color: colorPrimary,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                widget.config.appName() ?? 'Invalid',
                style: TextStyle(fontSize: 80, color: Colors.white, shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 32,
                  )
                ]),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: Text(
                    "กดเพิ่มเริ่มเกม",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: p,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dark_champion/configs/config.dart';
import 'package:dark_champion/cores/context.dart';
import 'package:dark_champion/middlewares/scaffold_middle_ware.dart';
import 'package:dark_champion/repositories/page_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  final BasePageRepository launchScreenRepository;

  LaunchScreen({
    required this.launchScreenRepository,
  });

  @override
  State<LaunchScreen> createState() {
    return _LaunchScreenState();
  }
}

class _LaunchScreenState extends State<LaunchScreen> {
  late IContext myContext;
  late IConfig config;

  @override
  void initState() {
    super.initState();

    this.config = Config();
    this.myContext = Context(
      buildCtx: this.context,
      config: config,
    );

    widget.launchScreenRepository.toLoadingStatus();
    this.initialConfig();
  }

  Future<void> initialConfig() async {
    try {
      await this.config.initial();
      await this.myContext.initial();
      await this.myContext.localeRepository().loadLocale();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ScaffoldMiddleWare(
            child: Container(),
          ),
        ),
      );

      widget.launchScreenRepository.toLoadedStatus();
    } catch (e) {
      widget.launchScreenRepository.toErrorStatus(e);
    }
  }

  @override
  void dispose() {
    super.dispose();

    widget.launchScreenRepository.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: widget.launchScreenRepository.isLoadingSC.stream,
        builder: (BuildContext context, snapshot) {
          return Center(
            child: Container(
              child: Icon(Icons.favorite),
            ),
          );
        },
      ),
    );
  }
}

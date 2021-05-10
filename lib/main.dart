import 'package:dark_champion/pages/launch_screen.dart';
import 'package:dark_champion/repositories/page_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LaunchScreen(
        launchScreenRepository: PageRepository(),
      ),
      theme: ThemeData(
        fontFamily: 'NTS',
      ),
    );
  }
}

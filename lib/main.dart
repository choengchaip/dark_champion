import 'package:dark_champion/pages/launch_screen.dart';
import 'package:dark_champion/repositories/page_repository.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
    );
  }
}

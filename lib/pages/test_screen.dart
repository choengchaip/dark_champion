import 'package:dark_champion/configs/config.dart';
import 'package:dark_champion/cores/context.dart';
import 'package:dark_champion/cores/controller/joystick.dart';
import 'package:dark_champion/cores/players/player.dart';
import 'package:dark_champion/cores/players/player_helper.dart';
import 'package:dark_champion/styles/fonts.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart' as flame;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  final IContext context;
  final IConfig config;

  TestScreen({
    required this.context,
    required this.config,
  });

  @override
  State<TestScreen> createState() {
    return _TestScreenState();
  }
}

class MyGame extends BaseGame
    with HasDraggableComponents, HasTapableComponents {
  late flame.Image image;
  late Sprite playerIMG;
  late final SpriteAnimationComponent player;
  late final Player bot;

  @override
  Future<void> onLoad() async {
    this.image = await images.load('wind_player.png');
    this.bot = Player(
      current: PlayerState.idle,
      removeOnFinish: {
        PlayerState.custom("01"): true,
        PlayerState.custom("02"): true,
        PlayerState.custom("03"): true,
        PlayerState.custom("04"): true,
        PlayerState.custom("05"): true,
      },
      animations: {
        PlayerState.idle: PlayerHelper.newPlayerAnimation(
          image: this.image,
          frameAmount: 8,
          row: 0,
          textureSize: Vector2(224, 112),
          loop: true,
        ),
        PlayerState.running: PlayerHelper.newPlayerAnimation(
          image: this.image,
          frameAmount: 8,
          row: 1,
          textureSize: Vector2(224, 112),
          loop: true,
        ),
        PlayerState.custom("01"): PlayerHelper.newPlayerAnimation(
          image: this.image,
          frameAmount: 8,
          row: 5,
          textureSize: Vector2(224, 112),
        ),
        PlayerState.custom("02"): PlayerHelper.newPlayerAnimation(
          image: this.image,
          frameAmount: 18,
          row: 6,
          textureSize: Vector2(224, 112),
        ),
        PlayerState.custom("03"): PlayerHelper.newPlayerAnimation(
          image: this.image,
          frameAmount: 26,
          row: 7,
          textureSize: Vector2(224, 112),
        ),
        PlayerState.custom("04"): PlayerHelper.newPlayerAnimation(
          image: this.image,
          frameAmount: 30,
          row: 8,
          textureSize: Vector2(224, 112),
        ),
        PlayerState.custom("05"): PlayerHelper.newPlayerAnimation(
          image: this.image,
          frameAmount: 19,
          row: 11,
          textureSize: Vector2(224, 112),
        ),
      },
      position: Vector2(200, 0),
      size: Vector2(448, 224),
    );

    add(this.bot);
    super.onLoad();
  }
}

class _TestScreenState extends State<TestScreen> {
  final myGame = MyGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            GameWidget(
              backgroundBuilder: (context) {
                return Container(
                  color: Colors.white,
                );
              },
              game: this.myGame,
            ),
            Positioned(
              top: 50,
              left: 250,
              child: Text(
                "SINGH GAME",
                style: TextStyle(
                  fontSize: h4,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 50,
              child: JoyStick(
                width: 150,
                onChange: (state) {
                  if (state == 1) {
                    this.myGame.bot.setState(PlayerState.running);
                  } else {
                    this.myGame.bot.setState(PlayerState.idle);
                  }
                },
              ),
            ),
            Positioned(
              top: 50,
              right: 50,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      this.myGame.bot.skill("01");
                    },
                    child: Text("Skill 01"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      this.myGame.bot.skill("02");
                    },
                    child: Text("Skill 02"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      this.myGame.bot.skill("03");
                    },
                    child: Text("Skill 03"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      this.myGame.bot.skill("04");
                    },
                    child: Text("Skill 04"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      this.myGame.bot.skill("05");
                    },
                    child: Text("Skill 05"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

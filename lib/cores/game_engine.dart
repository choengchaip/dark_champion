import 'package:dark_champion/cores/players/player.dart';
import 'package:dark_champion/cores/types.dart';
import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

abstract class IGameEngine {
  // initial game state
  Future<void> initial();

  // start game state
  void start();

  // addPlayer add player component to game engine return uuid of player
  String addPlayer(Player player);

  // addController add controller to player by playerId
  // void addController(String playerId);

  // sendEvent add event to game engine
  void sendEvent(IEventData event);

  // widget return game widget
  Widget widget();

  // images return flame images instance
  Images image();
}

class GameEngine implements IGameEngine {
  late Map<String, Map<String, dynamic>> players;
  late _GameInstance _gameInstance;

  GameEngine() {
    this.players = Map<String, Map<String, dynamic>>();
  }

  @override
  Future<void> initial() async {
    this._gameInstance = _GameInstance();
  }

  @override
  void start() {
  }

  @override
  String addPlayer(Player player) {
    String playerId = Uuid().v4();

    this.players.addAll({
      playerId: {
        "player": player,
      },
    });
    this._gameInstance.add(player);

    return playerId;
  }

  @override
  void sendEvent(IEventData event) {
    if (event.eventType == EventType.player) {
      IPlayerPayloadData payload = event.payload as IPlayerPayloadData;
      if (this.players[payload.playerId] != null) {
        Player player = (this.players[payload.playerId]!["player"]) as Player;
        player.skill(payload.skillId);
      }
    }
  }

  @override
  Images image() {
    return this._gameInstance.images;
  }

  @override
  Widget widget() {
    return GameWidget(
      backgroundBuilder: (_) {
        return Container(
          color: Colors.white,
        );
      },
      game: this._gameInstance,
    );
  }
}

class _GameInstance extends BaseGame with HasCollidables {
  _GameInstance();
}

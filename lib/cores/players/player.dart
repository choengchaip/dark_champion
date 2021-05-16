import 'dart:ui';
import 'package:flame/components.dart';
import 'package:meta/meta.dart';

class PlayerState {
  static String get idle {
    return "idle";
  }

  static String get walking {
    return "walking";
  }

  static String get running {
    return "running";
  }

  static String get attacking {
    return "attacking";
  }

  static String custom(String id) {
    return id;
  }
}

abstract class IPlayer {
  void skill(String skillId);
}

class Player extends PositionComponent implements IPlayer {
  late String current;

  Paint? overridePaint;

  final Map<String, bool> removeOnFinish;
  late Map<String, SpriteAnimation> animations;

  Player({
    required this.animations,
    required String current,
    Vector2? position,
    Vector2? size,
    this.overridePaint,
    this.removeOnFinish = const {},
  }) : super(
          position: position,
          size: size,
        ) {
    this.current = current;
  }

  SpriteAnimation? get animation => animations[this.current];

  void setState(String state) {
    this.current = state;
  }

  @override
  bool get shouldRemove {
    if (this.animation?.done() == true &&
        (removeOnFinish[this.current] ?? false)) {
      this.animation?.reset();
      this.current = PlayerState.idle;
    }

    return super.shouldRemove;
  }

  @override
  void skill(String skillId) {
    this.current = PlayerState.custom(skillId);
  }

  @mustCallSuper
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    animation?.getSprite().render(
          canvas,
          size: size,
          overridePaint: overridePaint,
        );
  }

  @mustCallSuper
  @override
  void update(double dt) {
    super.update(dt);
    animation?.update(dt);
  }
}

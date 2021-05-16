import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';

class PlayerHelper {
  PlayerHelper();

  static SpriteAnimation newPlayerAnimation({
    required Image image,
    required int frameAmount,
    required Vector2 textureSize,
    double? row,
    Vector2? texturePosition,
    double? stepTime,
    bool loop = false,
  }) {
    return SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        texturePosition:
            row != null ? Vector2(0, textureSize.y * row) : texturePosition,
        textureSize: textureSize,
        amount: frameAmount,
        stepTime: stepTime ?? 0.1,
        loop: loop,
      ),
    );
  }
}

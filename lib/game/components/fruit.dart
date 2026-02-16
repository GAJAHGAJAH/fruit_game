import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../fruit_catcher_game.dart';
import 'basket.dart';

class Fruit extends PositionComponent
    with HasGameRef<FruitCatcherGame>, CollisionCallbacks {

  final double fallSpeed = 200;
  final Random random = Random();

  Fruit({super.position}) : super(size: Vector2.all(40));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += fallSpeed * dt;

    if (position.y > gameRef.size.y + 50) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Basket) {
      gameRef.incrementScore();
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.primaries[random.nextInt(Colors.primaries.length)];

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      paint,
    );
  }
}

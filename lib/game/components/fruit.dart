import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../fruit_catcher_game.dart';
import 'basket.dart';

class Fruit extends PositionComponent
    with HasGameRef<FruitCatcherGame>, CollisionCallbacks {
  late Sprite sprite;

  final double fallSpeed = 200;

  Fruit({super.position}) : super(size: Vector2.all(60)); // ukuran buah

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('DIMASfOTO.jpeg');

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
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);

    // Clip agar gambar menjadi bulat
    canvas.save();
    canvas.clipPath(Path()..addOval(rect));

    sprite.render(canvas, size: size);

    canvas.restore();
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Basket) {
      gameRef.incrementScore();
      removeFromParent();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'game/fruit_catcher_game.dart';
import 'game/managers/audio_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi audio sebelum aplikasi jalan
  await AudioManager().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  late FruitCatcherGame game;

  @override
  void initState() {
    super.initState();
    game = FruitCatcherGame();
  }

  @override
  void dispose() {
    game.onRemove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// Layer 1 - Game Flame
          GameWidget(game: game),

          /// Layer 2 - Score
          Positioned(
            top: 50,
            left: 20,
            child: ValueListenableBuilder<int>(
              valueListenable: game.scoreNotifier,
              builder: (context, score, child) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Score: $score',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          /// Layer 3 - Control Musik & SFX
          Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.music_note, color: Colors.black),
                  onPressed: () {
                    AudioManager().toggleMusic();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.black),
                  onPressed: () {
                    AudioManager().toggleSfx();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

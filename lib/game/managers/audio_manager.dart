import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  bool _isMusicEnabled = true;
  bool _isSfxEnabled = true;
  double _musicVolume = 0.7;
  double _sfxVolume = 1.0;

  bool get isMusicEnabled => _isMusicEnabled;
  bool get isSfxEnabled => _isSfxEnabled;

  Future<void> initialize() async {
    await FlameAudio.audioCache.loadAll([
      'music/background_music.mp3',
      'sfx/collect.mp3',
      'sfx/explosion.mp3',
      'sfx/jump.mp3',
    ]);
  }

  void playBackgroundMusic() {
    if (_isMusicEnabled) {
      FlameAudio.bgm.play('assets/audio/music/background_music.mp3', volume: _musicVolume);
    }
  }

  void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
  }

  void toggleMusic() {
    _isMusicEnabled = !_isMusicEnabled;
    if (_isMusicEnabled) {
      FlameAudio.bgm.resume();
    } else {
      FlameAudio.bgm.pause();
    }
  }

  void toggleSfx() {
    _isSfxEnabled = !_isSfxEnabled;
  }

  void playSfx(String fileName) {
    if (_isSfxEnabled) {
      FlameAudio.play('sfx/$fileName', volume: _sfxVolume);
    }
  }
}

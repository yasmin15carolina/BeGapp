// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:universal_platform/universal_platform.dart';

class SoundEffects {
  static play(String path) async {
    final player = AudioPlayer();
    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
      await player.setAsset('assets/$path');
      player.play();
    } else if (UniversalPlatform.isWeb) {
      player.play();
    }
    // if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
    //   AudioCache audioCache = new AudioCache();
    //   audioCache.play(path);
    // } else if (UniversalPlatform.isWeb) {
    //   AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    //   audioPlayer.play('assets/assets/$path', isLocal: true);
    //   // audioPlayer.play('$path', isLocal: true);
    // }
  }
}

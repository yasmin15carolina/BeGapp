// import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/soundEffects.dart';

class AudioTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("play"),
          onPressed: () {
            // AudioCache audioCache = new AudioCache();
            // audioCache = new AudioCache();
            // audioCache.play('audio/ClockBell.mp3');
            SoundEffects.play('audio/ClockBell.mp3');
          },
        ),
      ),
    );
  }
}

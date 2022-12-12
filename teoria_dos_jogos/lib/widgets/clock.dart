import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class Clock extends StatelessWidget {
  final String animation;
  final double scale;

  Clock({required this.animation, this.scale: 1});
  Future<void> _warmupAnimations(assetProvider) async {
    await cachedActor(assetProvider);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    final AssetProvider assetProvider =
        AssetFlare(bundle: rootBundle, name: 'assets/flare/Clock.flr');
    _warmupAnimations(assetProvider);
    double size = screenHeight / 4;
    size *= scale;
    return Container(
        // color: Colors.red,
        height: size,
        width: size,
        child: FlareCacheBuilder([assetProvider],
            builder: (BuildContext context, bool isWarm) {
          return !isWarm
              ? Image.asset('assets/images/clock.png')
              : new FlareActor(
                  'assets/flare/Clock.flr',
                  alignment: Alignment.center,
                  animation: animation,
                  //animateClock,
                  fit: BoxFit.fill,
                );
        }));
  }
}

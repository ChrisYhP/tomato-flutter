
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/foundation.dart';


class AudioPlay {
  AudioPlayer advancedPlayer = new AudioPlayer();
  AudioCache audioCache = new AudioCache();
  
  init() {
    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }
  }

  play(url) {
    audioCache.play(url);
  }
}

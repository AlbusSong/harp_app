import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';

class SoundTool {
  Soundpool sp = Soundpool.fromOptions();
  Map soundDict = Map();
  int currentStreamId = -1;

  factory SoundTool() => _sharedInfo();

  static SoundTool _instance = SoundTool._();

  static SoundTool _sharedInfo() {
    return _instance;
  }

  SoundTool._() {
    _initSomeThings();
  }

  void _initSomeThings() {
    print("sp: ${sp}");
  }

  void playNote(String note) async {
    this.stopNote();

    String wavPath = "assets/wav/EWHarp_Normal_" + note + "_v3_RR1.wav";

    int soundId = -1;
    if (soundDict.containsKey(note)) {
      soundId = soundDict[note];
    } else {
      soundId = await rootBundle.load(wavPath).then((ByteData soundData) {
        return sp.load(soundData);
      });
      soundDict[note] = soundId;
    }

    print("soundId: ${soundId}");
    if (soundId == -1) {
      return;
    }

    this.currentStreamId = await sp.play(soundId);
  }

  void stopNote() {
    if (this.currentStreamId < 0) {
      return;
    }
    sp.stop(this.currentStreamId);
  }
}

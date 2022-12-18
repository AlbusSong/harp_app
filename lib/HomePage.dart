import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:io';
import 'package:harp_app/Others/Tool/GlobalTool.dart';
import 'package:harp_app/Others/Tool/SoundTool.dart';
import 'Others/Constants/GeneralConstants.dart';

// import 'package:flutter_sequencer/global_state.dart';
// import 'package:flutter_sequencer/models/sfz.dart';
// import 'package:flutter_sequencer/models/instrument.dart';
// import 'package:flutter_sequencer/sequence.dart';
// import 'package:flutter_sequencer/track.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_midi/flutter_midi.dart';
// import 'package:dart_melty_soundfont/dart_melty_soundfont.dart';
// import 'package:raw_sound/raw_sound_player.dart';
import 'package:midi_player/midi_player.dart';
import 'MyPainter.dart';
import 'FrostedGlassView.dart';
import 'AddNotesPage.dart';

class __MyPathClipper extends CustomClipper<Path> {
  // https://www.jianshu.com/p/9dca9e8cc4bc

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(150, 0);
    path.lineTo(size.width - 200, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final noteList = [
    "B2",
    "C3",
    "D3",
    "E3",
    "F3",
    "G3",
    "A3",
    "B3",
    "C4",
    "D4",
    "E4",
    "F4",
    "G4",
    "A4",
    "B4",
    "C5",
    "D5",
    "E5",
    "F5",
    "G5",
  ];

  // final sequence = Sequence(tempo: 120.0, endBeat: 8.0);
  // String _value = 'assets/Piano.sf2';

  // final instruments = [
  //   Sf2Instrument(path: "assets/sf2/Concert_Harp.sf2", isAsset: true),
  // ];

  // final _flutterMidi = FlutterMidi();

  // late Synthesizer synth;
  // final _playerPCMI16 = RawSoundPlayer();

  final _midiPlayer = MidiPlayer();

  late AnimationController _animController;
  int _pluckingIndex = -1;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    // load("assets/sf2/SuperHarp.sf2");
    // load("assets/sf2/Concert_Harp.sf2");
    // load("assets/sf2/Piano.sf2");

    // _load();

    _midiPlayer.load("assets/sf2/Edited_Concert_Harp.sf2");

    _animController =
        AnimationController(vsync: this, lowerBound: -0.05, upperBound: 0.05);
    _animController.addListener(() {
      // print(_animController.value);
      setState(() {});
    });
  }

  void _runAnim() {
    _stopAnim();

    const spring = SpringDescription(
      mass: 2,
      stiffness: 2000,
      damping: 4,
    );

    final simulation = SpringSimulation(spring, 0.05, 0, 300);
    _animController.animateWith(simulation);
  }

  void _stopAnim() {
    _animController.stop();
    // _animController.reset();
  }

  @override
  void dispose() {
    _animController.dispose();

    super.dispose();
  }

  // void _load() async {
  //   ByteData bytes = await rootBundle.load('assets/sf2/SuperHarp.sf2');

  //   synth = Synthesizer.loadByteData(
  //       bytes,
  //       SynthesizerSettings(
  //         sampleRate: 44100,
  //         blockSize: 64,
  //         maximumPolyphony: 64,
  //         enableReverbAndChorus: true,
  //       ));

  //   // Turn on some notes
  //   synth.noteOn(channel: 0, key: 72, velocity: 120);
  //   synth.noteOn(channel: 0, key: 76, velocity: 120);
  //   synth.noteOn(channel: 0, key: 79, velocity: 120);
  //   synth.noteOn(channel: 0, key: 82, velocity: 120);
  // }

  // void load(String asset) async {
  //   _flutterMidi.unmute();
  //   ByteData _byte = await rootBundle.load(asset);
  //   _flutterMidi.prepare(sf2: _byte);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.pink,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/bg.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            // color: randomColor(),
            child: ClipPath(
              clipper: __MyPathClipper(),
              child: FrostedGlassView(
                bgColor: hexColor("222222", 0.1),
                blurX: 20,
              ),
            ),
          ),
          SizedBox(
            // color: randomColor(),
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: MyPainter(),
            ),
          ),
          Positioned(
            child: _buildStringsArea(),
            left: 30,
            right: 0,
            top: 30,
            bottom: 30,
          ),
          Positioned(
            child: _buildAddNotesButton(),
            bottom: 100,
            left: 100,
          )
        ],
      ),
    );
  }

  Widget _buildStringsArea() {
    return Container(
      // color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _generateHarpStringWidgets(),
      ),
    );
  }

  Widget _generateSingleHarpString(int index) {
    double h = (SCREEN_H - 30 * 2) / 20;
    double full_w = (SCREEN_W - 30 - 10);
    double w = full_w * (1 - index * 0.029);
    return Container(
      // color: randomColor(),
      width: w,
      height: h,
      // child: Positioned(
      //   child: _generateString(index),
      //   top: 10,
      //   left: 0,
      //   right: 0,
      // ),
      child: Center(
        child: _generateString(index),
      ),
    );
  }

  Widget _generateString(int index) {
    String noteName = noteList[index];
    String noteColorStr = "ffffff";
    if (noteName.startsWith("C")) {
      noteColorStr = "329E54";
    } else if (noteName.startsWith("F")) {
      noteColorStr = "971111";
    }
    double full_h = 5;
    double h = full_h * (1 - index * 0.035);
    Container s = Container(
      color: hexColor(noteColorStr),
      height: h,
    );
    Container c = Container(
      // color: randomColor(),
      height: 40,
      child: Align(
        child: s,
        widthFactor: 1,
        heightFactor: 1,
        alignment:
            Alignment(0, (index == _pluckingIndex ? _animController.value : 0)),
      ),
    );

    GestureDetector g = GestureDetector(
        child: c,
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _stringClicked(index);
        });

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          noteName,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        Expanded(child: g),
      ],
    );
  }

  void _stringClicked(int index) async {
    print("_stringClicked: ${index}");

    // _flutterMidi.unmute();
    // _flutterMidi.playMidiNote(midi: 100);

    // Render the waveform (3 seconds)
    // ArrayInt16 buf16 = ArrayInt16.zeros(numShorts: 44100 * 3);
    // synth.renderMonoInt16(buf16);
    // await _playerPCMI16.feed(buf16);

    // _midiPlayer.playNote(note: 60);

    SoundTool().playNote(noteList[index]);

    _pluckingIndex = index;
    _runAnim();
  }

  List<Widget> _generateHarpStringWidgets() {
    List<Widget> wgtList = [];

    for (int i = 0; i < 20; i++) {
      Widget w = _generateSingleHarpString(i);
      wgtList.add(w);
    }

    return wgtList;
  }

  Widget _buildAddNotesButton() {
    Container c = Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      // color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/MusicNote.png",
            width: 80,
            height: 80,
            // fit: BoxFit.fitHeight,
          ),
          Text(
            "Add Notes",
            style: TextStyle(
                color: hexColor("723030"),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                      color: hexColor("000000", 0.2),
                      offset: Offset(1, 0),
                      blurRadius: 1),
                ]),
          )
        ],
      ),
    );

    return GestureDetector(
      child: c,
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _addNotesButtonClicked();
        // _playSequenceNotes(["2", "3"]);
      },
    );
  }

  void _addNotesButtonClicked() async {
    List<String> noteArr = await presentNewPage(context, AddNotesPage());

    Future.delayed(Duration(seconds: 1), () {
      _playSequenceNotes(noteArr);
    });
  }

  void _playSequenceNotes(List<String> noteArr) {
    for (int i = 0; i < noteArr.length; i++) {
      String noteStr = noteArr[i];
      int transformedNoteIndex = _transformNoteStrToIndex(noteStr);
      Future.delayed(Duration(milliseconds: 600 * i), () {
        if (transformedNoteIndex >= 0) {
          _stringClicked(transformedNoteIndex);
        }
      });
      // sleep(Duration(seconds: 1 * i));
    }
  }

  int _transformNoteStrToIndex(String noteStr) {
    int result = -1;
    if (noteStr == "|" || noteStr == "-") {
      result = -1;
    } else if (noteStr == "0") {
      result = -1;
    } else {
      int extraMark = 0;
      if (noteStr.length == 2) {
        if (noteStr.startsWith("-")) {
          extraMark = -1;
        } else {
          extraMark = 1;
        }

        noteStr = noteStr.substring(1, 2);
      }

      int noteInt = int.parse(noteStr);
      result = noteInt + 7 + (extraMark * 7);
    }

    return result;
  }
}

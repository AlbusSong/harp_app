import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:harp_app/Others/Tool/GlobalTool.dart';

class SpringAnimPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SpringAnimPageState();
  }
}

class _SpringAnimPageState extends State<SpringAnimPage>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  // Alignment _pluckAlignment = Alignment(0.5, 0);
  // late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, lowerBound: -0.5, upperBound: 0.5);
    _animController.addListener(() {
      // print("_animation.value: ${_animation.value}");
      print(_animController.value);
      setState(() {});
      // if (_animation.isCompleted) {
      //   setState(() {
      //     _pluckAlignment = Alignment(0.5, 0);
      //   });
      // } else {
      //   setState(() {
      //     _pluckAlignment = _animation.value;
      //   });
      // }
    });
  }

  void _runAnim() {
    _stopAnim();

    // _animation = _animController.drive(
    //   AlignmentTween(
    //     // begin: _pluckAlignment,
    //     begin: Alignment(0.5, 0),
    //     end: Alignment.center,
    //   ),
    // );

    // _animController.reset();
    // _animController.forward();

    const spring = SpringDescription(
      mass: 2,
      stiffness: 200,
      damping: 3,
    );

    final simulation = SpringSimulation(spring, 0.5, 0, 20);
    _animController.animateWith(simulation);

    // _animController.fling(velocity: 10);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Align(
          child: _buildAnimationBlock(),
          alignment: Alignment(_animController.value, 0),
        ),
        Align(
          child: Container(
            // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: hexColor("80b5a8"),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                fixedSize: Size(200, 55),
              ),
              onPressed: () {
                _runAnim();
              },
              child: Text(
                "Start Animation",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          alignment: Alignment(0, 0.5),
        ),
      ],
    );
  }

  Widget _buildAnimationBlock() {
    return Container(
      color: hexColor("459999"),
      width: 200,
      height: 200,
    );
  }
}

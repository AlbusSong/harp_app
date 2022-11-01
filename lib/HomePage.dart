import 'package:flutter/material.dart';
import 'package:harp_app/Others/Tool/GlobalTool.dart';
import 'Others/Constants/GeneralConstants.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
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
    return Container(
      color: Colors.pink,
      child: Stack(
        children: [
          Positioned(
            child: _buildStringsArea(),
            left: 30,
            right: 10,
            top: 30,
            bottom: 30,
          ),
          Positioned(
            child: _buildSettingsButton(),
            bottom: 50,
            left: 30,
          )
        ],
      ),
    );
  }

  Widget _buildStringsArea() {
    return Container(
      color: Colors.amber,
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
    double w = full_w * (1 - index * 0.025);
    return Container(
      // color: randomColor(),
      width: w,
      height: h,
      child: Center(
        child: _generateString(index),
      ),
    );
  }

  Widget _generateString(int index) {
    Container c = Container(
      // color: randomColor(),
      height: 40,
      child: Center(
        child: Container(
          color: Colors.white,
          height: 5,
        ),
      ),
    );

    return GestureDetector(
        child: c,
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _stringClicked(index);
        });
  }

  void _stringClicked(int index) {
    print("hhhdddd: ${index}");
  }

  List<Widget> _generateHarpStringWidgets() {
    List<Widget> wgtList = [];

    for (int i = 0; i < 20; i++) {
      Widget w = _generateSingleHarpString(i);
      wgtList.add(w);
    }

    return wgtList;
  }

  Widget _buildSettingsButton() {
    return Container(
      width: 60,
      height: 60,
      color: Colors.green,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:harp_app/Others/Tool/GlobalTool.dart';
import 'package:harp_app/Others/Tool/LocalDataTool.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddNotesPageState();
  }
}

class _AddNotesPageState extends State<AddNotesPage> {
  int _goingToBeSelectedIndex = -1;
  int _goingToBeSelectedSubnoteIndex = -1;
  List<String> noteArr = LocalDataTool().getLocalNoteArr();

  bool _shouldShowTopRightActions = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("F1F1F1"),
      appBar: AppBar(
        title: Text(
          "Add Notes",
          style: TextStyle(
            color: hexColor("666666"),
          ),
        ),
        backgroundColor: hexColor("e2e2e2"),
        foregroundColor: hexColor("666666"),
        actions: [_buildRightActionButton()],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      // color: randomColor(),
      child: Stack(children: [
        Align(
          child: Image.asset(
            "assets/images/Music_note_icon.png",
            fit: BoxFit.cover,
          ),
          alignment: Alignment(0, -0.3),
        ),
        Align(
          alignment: Alignment(0, -0.95),
          child: _buildMusicNotesDisplayArea(),
        ),
        Align(
          alignment: Alignment(0, 0.90),
          child: _buildMusicNotesInputArea(),
        ),
        Align(
          alignment: Alignment(0.96, -0.99),
          child: _buildTopRightActionsArea(),
        ),
      ]),
    );
  }

  Widget _buildTopRightActionsArea() {
    Container wrapper = Container(
      width: 164,
      height: 141,
      child: Column(
        children: [
          Align(
            alignment: Alignment(0.9, 0),
            child: Image.asset(
              "assets/images/Up_Triangle_Icon.png",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: hexColor("dddddd"),
                  width: 1,
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: () {
                    List<String> actionButtonTitles = ["Play", "Save", "Clear"];
                    List<Widget> res = [];
                    for (int i = 0; i < actionButtonTitles.length; i++) {
                      String actionButtonTitle = actionButtonTitles[i];
                      Container c = Container(
                        height: 40,
                        decoration: BoxDecoration(
                            // color: randomColor(),
                            border: () {
                          if (i < 2) {
                            return Border(
                              bottom: BorderSide(
                                width: 1,
                                color: hexColor("dddddd"),
                              ),
                            );
                          } else {
                            return null;
                          }
                        }()),
                        child: TextButton(
                          child: Text(
                            actionButtonTitle,
                            style: TextStyle(
                              fontSize: 20,
                              color: hexColor("723030"),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            fixedSize: Size(163, 39),
                          ),
                          onPressed: () {
                            _topRightActionClicked(i);
                          },
                        ),
                      );

                      res.add(c);
                    }

                    return res;
                  }()),
            ),
          )
        ],
      ),
    );

    return Visibility(visible: _shouldShowTopRightActions, child: wrapper);
  }

  Widget _buildMusicNotesDisplayArea() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: () {
          List<Widget> res = [];
          for (int i = 0; i < noteArr.length; i++) {
            String noteStr = noteArr[i];

            if (noteStr != "|") {
              int extraMark = 0;
              if (noteStr.length == 2) {
                if (noteStr.startsWith("-")) {
                  extraMark = -1;
                } else {
                  extraMark = 1;
                }

                noteStr = noteStr.substring(1, 2);
              }
              res.add(_buildReadOnlyNoteItem(noteStr, extraMark: extraMark));
            } else {
              res.add(_buildReadOnlyNoteItem("|", extraMark: 0));

              SizedBox emt = SizedBox(width: double.infinity, height: 40);
              res.add(emt);
            }
          }
          return res;
        }(),
      ),
    );
  }

  Widget _buildMusicNotesInputArea() {
    return Container(
      width: 440,
      height: 156,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: () {
              List<Widget> res = [];

              if (_goingToBeSelectedIndex >= 0) {
                if (_goingToBeSelectedIndex == 0) {
                  Widget noteItem = _buildNoteItem("0", 0, 0);
                  res.add(noteItem);
                } else {
                  String theNoteStr = _goingToBeSelectedIndex.toString();
                  Widget noteItem0 =
                      _buildNoteItem(theNoteStr, 0, 0, extraMark: -1);
                  Widget noteItem1 =
                      _buildNoteItem(theNoteStr, 0, 1, extraMark: 0);
                  Widget noteItem2 =
                      _buildNoteItem(theNoteStr, 0, 2, extraMark: 1);
                  res.add(noteItem0);
                  res.add(noteItem1);
                  res.add(noteItem2);
                }
              } else {
                SizedBox emt = SizedBox(height: 40);
                res.add(emt);
              }

              return res;
            }(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNoteItem("0", 1, 0),
              _buildNoteItem("1", 1, 1),
              _buildNoteItem("2", 1, 2),
              _buildNoteItem("3", 1, 3),
              _buildNoteItem("4", 1, 4),
              _buildNoteItem("5", 1, 5),
              _buildNoteItem("6", 1, 6),
              _buildNoteItem("7", 1, 7),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNoteItem("-", 2, 0),
              _buildNoteItem("|", 2, 1),
              _buildNoteItem("x", 2, 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(String noteItemStr, int rowIndex, int columnIndex,
      {int extraMark = 0}) {
    Container c = Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: () {
          if (rowIndex == 0) {
            if (_goingToBeSelectedSubnoteIndex == columnIndex) {
              return hexColor("CCCCCC");
            }
          } else if (rowIndex == 1) {
            if (_goingToBeSelectedIndex == columnIndex) {
              return hexColor("dddddd");
            }
          }

          return Colors.white;
        }(),
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.all(
          width: 2,
          color: hexColor("D7D7D7"),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            noteItemStr,
            style: TextStyle(
              color: hexColor("723030"),
              fontSize: 20,
            ),
          ),
          Visibility(
            visible: (extraMark != 0),
            child: () {
              Text txt = Text(
                "●",
                style: TextStyle(
                  color: hexColor("723030"),
                  fontSize: 4,
                ),
              );

              if (extraMark == 1) {
                return Positioned(top: 4, child: txt);
              } else {
                return Positioned(bottom: 4, child: txt);
              }
            }(),
          ),
        ],
      ),
    );

    return GestureDetector(
      child: c,
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _selectedNoteItemAt(rowIndex, columnIndex);
      },
    );
  }

  Widget _buildReadOnlyNoteItem(String noteItemStr, {int extraMark = 0}) {
    Container c = Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 40,
      height: 40,
      // color: randomColor(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            noteItemStr,
            style: TextStyle(
              color: hexColor("723030"),
              fontSize: 20,
            ),
          ),
          Visibility(
            visible: (extraMark != 0),
            child: () {
              Text txt = Text(
                "●",
                style: TextStyle(
                  color: hexColor("723030"),
                  fontSize: 4,
                ),
              );

              if (extraMark == 1) {
                return Positioned(top: 4, child: txt);
              } else {
                return Positioned(bottom: 4, child: txt);
              }
            }(),
          ),
        ],
      ),
    );

    return c;
  }

  Widget _buildRightActionButton() {
    Container c = Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      // color: randomColor(),
      child: Image.asset(
        "assets/images/action_more_icon.png",
        fit: BoxFit.cover,
      ),
    );

    return GestureDetector(
      child: c,
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _shouldShowTopRightActions = !_shouldShowTopRightActions;
        });
      },
    );
  }

  void _selectedNoteItemAt(int rowIndex, int columnIndex) {
    if (rowIndex == 0) {
      print("ksk");

      String goingToBeAddedNoteStr = "";
      if (_goingToBeSelectedIndex == 0) {
        goingToBeAddedNoteStr = "0";
      } else {
        String signStr = "";
        if (columnIndex == 0) {
          signStr = "-";
        } else if (columnIndex == 2) {
          signStr = "+";
        }
        goingToBeAddedNoteStr = signStr + _goingToBeSelectedIndex.toString();
      }
      noteArr.add(goingToBeAddedNoteStr);

      setState(() {
        _goingToBeSelectedSubnoteIndex = columnIndex;
      });
    } else if (rowIndex == 1) {
      print("nnneaa");
      if (_goingToBeSelectedIndex == columnIndex) {
        return;
      }

      setState(() {
        _goingToBeSelectedIndex = columnIndex;
        _goingToBeSelectedSubnoteIndex = -1;
      });
    } else {
      print("nnnasfa");

      setState(() {
        if (columnIndex == 0) {
          noteArr.add("-");
        } else if (columnIndex == 1) {
          noteArr.add("|");
        } else {
          noteArr.removeLast();
        }
      });
    }
  }

  void _topRightActionClicked(int index) {
    if (index == 0) {
      if (noteArr.length == 0) {
        showMsg("Empty notes", true);
        return;
      }
      Navigator.of(context).pop(noteArr);
    } else if (index == 1) {
      LocalDataTool().saveNoteArrToLocal(noteArr);
      showMsg("Saved");
    } else {
      noteArr.clear();
    }

    setState(() {
      _shouldShowTopRightActions = false;
    });
  }

  void showMsg(String msg, [bool isError = false]) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Color.fromARGB(151, 48, 176, 19),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

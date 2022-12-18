import 'package:shared_preferences/shared_preferences.dart';

class LocalDataTool {
  late SharedPreferences prefs;

  factory LocalDataTool() => _sharedInfo();

  static LocalDataTool _instance = LocalDataTool._();

  static LocalDataTool _sharedInfo() {
    return _instance;
  }

  LocalDataTool._() {
    _initSomeThings();
  }

  void _initSomeThings() async {
    prefs = await SharedPreferences.getInstance();
  }

  void saveNoteArrToLocal(List<String> noteArr) async {
    prefs.setStringList("noteArr", noteArr);
  }

  List<String> getLocalNoteArr() {
    List<String>? res = prefs.getStringList('noteArr');

    if (res != null) {
      return res;
    } else {
      return [];
    }
  }
}

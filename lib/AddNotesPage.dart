import 'package:flutter/material.dart';
import 'package:harp_app/Others/Tool/GlobalTool.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddNotesPageState();
  }
}

class _AddNotesPageState extends State<AddNotesPage> {
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
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
        // color: randomColor(),
        );
  }
}

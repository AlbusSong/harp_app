import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Others/Tool/GlobalTool.dart';
import 'Others/Tool/LocalDataTool.dart';
import 'SpringAnimPage.dart';

void main() {
  runApp(const MyApp());

  LocalDataTool();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harp App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: hexColor("723030"),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


// Reference:
// https://felixblaschke.medium.com/particle-animations-with-flutter-756a23dba027
// https://blog.csdn.net/sinat_17775997/article/details/106717551
// https://juejin.cn/post/6844904139038654472
// https://www.jianshu.com/p/22dc3488bc40

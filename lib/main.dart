import 'package:flutter/material.dart';
import 'package:pixabay_project/ImagesList/view/images_listview.dart';
import 'package:pixabay_project/common_classes/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ImagesListView(),
    );
  }
}


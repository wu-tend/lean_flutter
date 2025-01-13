import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// アプリそのもの
class MyApp extends StatelessWidget { //StatelessWidget: ステートを持たないことの意。ページ単位で状態を持つのでここでは不要
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { //buildは見た目を定めるものっぽい
    return MaterialApp( //MaterialUIを使用する
      title: 'Flutter Sample', //App title
      theme: ThemeData( // 全体像を定める
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // ここからページについての記載
      home: const MySlider(), //アプリのHomeページとしてMySliderを作成
      // home: const MyWidget3(),
    );
  }
}

class MySlider extends StatefulWidget {
  const MySlider({Key? key,}) : super(key: key); //コンストラクタ

  @override
  State <MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {

  double _curSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              value: _curSliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: _curSliderValue.round().toString(),
              onChanged: (double value){
                setState(() {
                  _curSliderValue = value;
                });
                print('CurrentSlider: ${_curSliderValue.round()}');
              }
            ),
            Text('Selected Value: ${_curSliderValue.round()}')
          ],
        ),
      )
    );
  }
}
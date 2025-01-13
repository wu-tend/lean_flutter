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
      home: const MyHomePage(title: 'Flutter Sample Homepage'), //アプリのHomeページとしてMyHomePageを作成
      // home: const MyWidget3(),
    );
  }
}

class MyHomePage extends StatefulWidget { //StatefulWidget: ステートを持つことの意
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(); //MyHomePageに_MyHomePageStateを持たせる
}

class _MyHomePageState extends State<MyHomePage> { //MyHomePageを継承
  
  int _height = 0;
  double _weight = 0.0;
  double _bmi = 0.0;

  @override
  Widget build(BuildContext build){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //Columnにおいては左寄せ
          children: [
            const Text("身長(cm)"),
            TextField( // テキストボックス
              onChanged: (value){
                _height = int.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 16,), //SizeBoxはスペースを作るもの()内にカンマがあって正しい
            const Text("体重(kg)"),
            TextField( // テキストボックス
              onChanged: (value){
                _weight = double.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 24,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: (){
                setState(() {
                  _bmi = _weight / pow(_height/100, 2);
                });
              },
              child: const Text("計算する"),
            ),
            const SizedBox(height: 16,),
            Text("BMIは$_bmiです。")
          ],
        ),
      )
    );
  }
}
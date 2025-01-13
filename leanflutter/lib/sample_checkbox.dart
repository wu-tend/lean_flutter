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
      home: const MyCheckBox(), //アプリのHomeページとしてMyCheckBoxを作成
      // home: const MyWidget3(),
    );
  }
}

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({Key? key,}) : super(key: key); //コンストラクタ

  @override
  State <MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  
  bool isChecked = false;
  
  void _toggleCheckBox(){
    setState((){
      isChecked = !isChecked;
    });
    print("Change CheckBox");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('利用規約'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('利用規約に同意しますか'),
                value: isChecked, 
                onChanged: (value){
                  _toggleCheckBox();
                }
              ),
            ),
            Text('isChecked: ${isChecked}'),
          ],
        ),
      )
    );
  }
}
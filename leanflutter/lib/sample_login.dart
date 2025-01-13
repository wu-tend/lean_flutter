import 'dart:io';

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
  @override
  Widget build(BuildContext build){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14))
              ),
              onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog( //showDialogはreturn AlertDialog()が必須となる。らしい。
                    // title: const Text("I'm Dialog"),
                    content: const Text("Login Successful"),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, 
                        child: const Text('close'))
                    ],
                  );
                });
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14))
              ),
              onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog( //showDialogはreturn AlertDialog()が必須となる。らしい。
                    // title: const Text("I'm Dialog"),
                    content: const Text("Register Account"),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, 
                        child: const Text('close'))
                    ],
                  );
                });
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog( //showDialogはreturn AlertDialog()が必須となる。らしい。
                    // title: const Text("I'm Dialog"),
                    content: const Text("Password Updated"),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, 
                        child: const Text('close'))
                    ],
                  );
                });
              },
              child: const Text("Forget Password?")
            )
          ],
        ),
      )
    );
  }
}
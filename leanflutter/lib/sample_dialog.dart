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
  Widget build(BuildContext context) { //ページ内のWidgetを指定（ページの見た目を決める）
    return Scaffold(
      appBar: AppBar( //Headerバー
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                // ダイアログ表示
                showDialog(context: context, builder: (context){
                  return AlertDialog( //showDialogはreturn AlertDialog()が必須となる。らしい。
                    title: const Text("I'm Dialog"),
                    content: const Text("Alert Dialog"),
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
              child: const Text("Press")
            ),
            OutlinedButton( //枠線つきの平面ボタン
              onPressed: () {
                print("hogehoge");
              }, 
              child: const Text("fuga")
            )
          ]
        )
      )
    );
  }
}
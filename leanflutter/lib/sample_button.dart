import 'package:flutter/foundation.dart';
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
      title: 'Flutter Demo', //App title
      theme: ThemeData( // 全体像を定める
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // ここからページについての記載
      home: const MyHomePage(title: 'Flutter デモ ホームページ'), //アプリのHomeページとしてMyHomePageを作成
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
  int _counter = 0;
  final Color _myColor = Colors.red;

  void _incrementCounter() { //ステートの関数
    setState(() { //setState: UIに状態を渡す関数
      _counter += 2 ;
    });
  }

  @override
  Widget build(BuildContext context) { //ページ内のWidgetを指定（ページの見た目を決める）
    return Scaffold(
      backgroundColor: _counter % 4 == 0 ? Colors.yellow: _myColor,
      appBar: AppBar( //Headerバー
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center( //ページ本体
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const MyWidget1(),
            const Text(
              'ボタンを押した回数がわかるよ:',
            ),
            const MyWidget2(),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const MyWidget3(),
            ElevatedButton( //body内で一番よくあるボタン
              style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(0))),//角丸なし
                  borderRadius: BorderRadius.circular(14))),
              // shape: CircleBorder(), //丸ボタンにする
              //   padding: EdgeInsets.all(34),
              onPressed: () {
                // ここに押した時の処理を記述します；
                if(kDebugMode) print('押しました！');
              },
              child: const Text('押してね'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( //浮いた（影付き）ボタン。丸いやつ
        onPressed: _incrementCounter, //押下時のアクション
        tooltip: 'Increment', //ホバーした際に補足情報を表示する
        child: const Icon(Icons.add), // アイコンはMaterialUIのaddアイコン（プラスアイコン）を使用
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyWidget1 extends StatelessWidget {
  const MyWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Apple");
  }
}

class MyWidget2 extends StatelessWidget {
  const MyWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Tomato");
  }
}

class MyWidget3 extends StatelessWidget {
  const MyWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Hoge");
  }
}
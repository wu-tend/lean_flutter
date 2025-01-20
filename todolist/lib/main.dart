import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:intl/intl.dart';

// アプリ起動時にFirebaseを初期化する
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const collectionKey = 'tendo_todo';

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = [];
  final TextEditingController _textEditingController = TextEditingController();
  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    watch();
  }

  // データ更新の監視
  Future<void> watch() async {
    firestore.collection(collectionKey).snapshots().listen((event) { //collectionに何か変化があれば実行される
      setState(() { //画面を更新する
        items = event.docs.reversed //データを逆順にすることで、最新のデータが一番上に表示されるようにする
          .map(
            (document) => Item.fromSnapshot(
              document.id,
              document.data(),              
            )
          )
          .toList(growable: false); //growable: falseにすることで、リストの要素数を変更できなくする
      });
    });
  }

  // データの保存
  Future<void> save() async {
    final collection = firestore.collection(collectionKey);
    final now = DateTime.now();
    await collection.doc(now.millisecondsSinceEpoch.toString()).set({
      'data': now,
      'text': _textEditingController.text,
    });
    _textEditingController.text = '';
  }

  // 完了・未完了に変更する
  Future<void> complete(Item item) async {
    final collection = firestore.collection(collectionKey);
    await collection.doc(item.id).set(
      {
        'isCompleted': !item.isCompleted, //isCompletedを反転する
      },
      SetOptions(merge: true), //merge: trueにすることで、既存のデータに上書きせず、データを追加する
    );
  }

  // 削除する
  Future<void> delete(String id) async {
    final collection = firestore.collection(collectionKey);
    await collection.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                title: TextField(
                  controller: _textEditingController,
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    save();
                  },
                  child: const Text("保存"),
                ),
              );
            }
            final item = items[index - 1];
            return Dismissible(
              key: Key(item.id),
              onDismissed: (direction) {
                delete(item.id);
              },
              child: ListTile(
                leading: Checkbox(
                  value: item.isCompleted,
                  onChanged: (value) {
                    complete(item);
                  },
                ),
                title: Text(item.text),
                subtitle: Text(
                  // item.date.toString().replaceAll('-', '/').substring(0, 19),
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(item.date),
                ),
              ),
            );
          },
          itemCount: items.length + 1,
        ),
      ),
    );
  }
}

class Item {
  const Item({
    required this.id,
    required this.text,
    required this.isCompleted,
    required this.date,
  });

  final String id;
  final String text;
  final bool isCompleted;
  final DateTime date;

  factory Item.fromSnapshot(String id, Map<String, dynamic> document) {
    return Item(
      id: id,
      text: document['text'].toString(),
      isCompleted: document['isCompleted'] ?? false,
      date: (document['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
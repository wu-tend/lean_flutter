import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future<void> main() async{
  /** runAppの前にFirebaseを初期化する */ 
  // 外部サービスを初期化するときに初期化を保証するおまじない的なやつ
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
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

class _MyHomePageState extends State<MyHomePage> {
  
  String name = '';
  String room = '';

  // エラー表示
  void showError(String message){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message)
        );
      },
    );
  }

  // 入室処理
  void enter(){
    if(name.isEmpty){
      showError('User name is empty');
      return;
    }
    if(room.isEmpty){
      showError('Room name is empty');
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context){
          return ChatPage(name: name, room: room);
        }
      ),
    );
  }

  // 退室処理
  void exit(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("チャット"),
      ),
      body:  ListView(
        children: [
          ListTile(
            title: TextField(
              decoration: const InputDecoration(hintText: "Your name"),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              }
            )
          ),
          ListTile(
            title: TextField(
              decoration: const InputDecoration(hintText: "Room name"),
              onChanged: (value) {
                setState(() {
                  room = value;
                });
              }
            )
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                enter();
              },
              child: const Text('Enter the room')
            )
          )
        ],
      )
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({required this.name, required this.room, super.key});

  final String name;
  final String room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Item> items = [];
  late FirebaseFirestore firestore;
  late CollectionReference<Map<String, dynamic>> collection;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    collection = firestore.collection('rooms').doc(widget.room).collection('items');
    match();
  }

  // データ更新監視
  Future<void> match() async {
    collection.snapshots().listen((event) {
      if(mounted){ //mounted: 非同期処理でwidgetが破棄される際にエラーが起きるのを防ぐ
        setState(() {
          items = event.docs.reversed
            .map(
              (document) => Item.fromSnapshot(
                document.id,
                document.data(),
              ),
            )
            .toList(growable: false);
        });
      }
    });
  }

  // データの保存
  Future<void> save() async {
    final now = DateTime.now();
    await collection.doc(now.millisecondsSinceEpoch.toString()).set({
      'date': Timestamp.fromDate(now),
      'name': widget.name,
      'text': textEditingController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.room)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemBuilder: (context, index) {
                final item = items[index];
                final isMe = widget.name == item.name;
                return Padding(
                  padding: isMe
                    ? const EdgeInsets.only(left: 80, right: 16, top: 16)
                    : const EdgeInsets.only(left: 16, right: 80, top: 16),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), 
                    tileColor: isMe ? Colors.tealAccent : Colors.black12,
                    title: Text(item.text),
                    subtitle: Text(
                      '${item.name} ${DateFormat('yyyy-MM-dd HH:mm:ss').format(item.date)}',
                    ),
                  )
                );
              },
              itemCount: items.length,
            )
          ),
          SafeArea(
            child: ListTile(
              title: TextField(
                controller: textEditingController,
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  save();
                  textEditingController.clear();
                }, 
                child: const Text('Send'),
              )
            )
          )
        ],
      )
    ); 
  }
}

class Item {
  const Item({
    required this.id,
    required this.name,
    required this.text,
    required this.date,
  });

  final String id;
  final String name;
  final String text;
  final DateTime date;

  // factory Item.fromSnapshot: ファクトリコンストラクタ - 外部から値を変更できないため、カプセル化（秘匿）できる
  factory Item.fromSnapshot(String id, Map<String, dynamic> document) {
    return Item(
      id: id,
      name: document['name'].toString(),
      text: document['text'].toString(),
      date: (document['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
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

  List<Map<String, String>> contacts = [
    {'name': 'hogehoge', 'number': '060-1234-5678', 'address': '東京'},
    {'name': 'fugafuga', 'number': '080-1234-5678', 'address': '神奈川'},
    {'name': 'honyarara', 'number': '090-1234-5678', 'address': '埼玉'},
  ];

  void _pushPage(contact){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailPage(contact: contact);
        }
      )
    );
  }

  void _modalPage(contact){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context){
          return DetailPage(contact: contact);
        },
        fullscreenDialog: true,
      )
    );
  }

  @override
  Widget build(BuildContext build){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title)
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.phone),
            title: Text(contacts[index]['name']!),
            subtitle: Text(contacts[index]['number']!),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: (){
              _pushPage(contacts[index]);
            },
          );
        }
      )
    );
  }
}

class DetailPage extends StatelessWidget{

  const DetailPage({Key? key, required this.contact}) : super(key: key);

  final Map<String, String> contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${contact['name']}'),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 15,),
                const Icon(
                  size: 40,
                  Icons.account_circle
                ),
                Text(
                  'Name: ${contact['name']}',
                  style: TextStyle(fontSize: 20),
                ),
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 15,),
                const Icon(
                  size: 40,
                  Icons.phone
                ),
                Text(
                  'Number: ${contact['number']}',
                  style: TextStyle(fontSize: 20),
                ),
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 15,),
                const Icon(
                  size: 40,
                  Icons.home
                ),
                Text(
                  'Address: ${contact['address']}',
                  style: TextStyle(fontSize: 20),
                ),
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: (){

              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, size: 30),
                  Text(
                    'Call',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
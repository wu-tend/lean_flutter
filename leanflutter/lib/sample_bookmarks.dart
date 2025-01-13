import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Flutter Page'),
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

  List<Map<String, String>> bookmarks = [
    {'name': 'Flutter', 'url': 'https://flutter.dev/'},
    {'name': 'Google', 'url': 'https://www.google.com/'},
    {'name': 'Youtube', 'url': 'https://www.youtube.com/'},
  ];

  void _pushPage(bookmark){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WebViewPage(bookmark: bookmark);
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Bookmerks"),
      ),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(bookmarks[index]['name']!),
            onTap: (){
              _pushPage(bookmarks[index]);
            },
          );
        }
      )
    );
  }
}

class WebViewPage extends StatefulWidget{
  const WebViewPage({super.key, required this.bookmark});
  final Map<String, String> bookmark;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // webviewはデフォでJSが無効になっているため有効化する
      ..loadRequest(Uri.parse(widget.bookmark['url'] ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.bookmark['name']!),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
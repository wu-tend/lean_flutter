import 'package:flutter/material.dart';
import 'dart:async';
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
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // webviewはデフォでJSが無効になっているため有効化する
      ..loadRequest(Uri.parse('https://www.youtube.com/watch?v=jzUlLi6JFVA&t=2s'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // SafeArea: AppBarなどの領域を侵さない
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}

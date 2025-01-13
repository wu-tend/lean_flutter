import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  TextEditingController controller =  TextEditingController();
  List<String> items = [];
  String errorMessage = '';

  Future<void> loadZipCode(String zipCode) async {
    
    setState(() {
      errorMessage = 'Waiting API Response';
    });

    final response = await http.get(
      Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipCode')
    );

    if(response.statusCode != 200){
      // Reqiest Error
      return;
    }

    final body = json.decode(response.body) as Map<String, dynamic>;
    final results = (body['results'] ?? []) as List<dynamic>;
    
    if(results.isEmpty){
      setState(() {
        errorMessage = 'ZipCode does not exist';
      });
    }
    else{
      setState(() {
        errorMessage = '';
        items = results.map((result) => 
          '${result['address1']}${result['address2']}${result['address3']}')
        .toList(growable: false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (value){
            if(value.isNotEmpty){
              loadZipCode(value);
            }
          },
        )
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          if(errorMessage.isNotEmpty){
            return ListTile(
              title: Text(errorMessage),
            );
          }
          else{
            return ListTile(
              title: Text(items[index]),
            );
          }
        },
      )
    );
  }
}

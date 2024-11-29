
 import 'dart:js' as js; // JavaScript interop을 위한 패키지
import 'package:flutter/material.dart';
import 'package:webengage_flutter/webengage_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '과일 리스트',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FruitListPage(),
    );
  }
}

class FruitListPage extends StatelessWidget {
  // 과일 리스트
  final List<String> fruits = ['사과', '바나나', '오렌지', '망고', '포도'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('과일 리스트'),
      ),
      body: ListView.separated(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(fruits[index]),
            onTap: () {
              // 상세 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FruitDetailPage(fruitName: fruits[index]),
                ),
              );
            },
          );
        }, separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 1); },
      ),
    );
  }
}

class FruitDetailPage extends StatefulWidget {
  final String fruitName;

  FruitDetailPage({required this.fruitName});

  @override
  _FruitDetailPageState createState() => _FruitDetailPageState();

}

class _FruitDetailPageState extends State<FruitDetailPage> {
   late WebViewController _controller;

   // 과일 클릭 시 JavaScript로 데이터를 보내는 함수
   void sendToNative(String fruitName) {
     // Android 네이티브 앱으로 과일 이름을 전달하는 JavaScript 함수 호출
     js.context.callMethod('sendFruitName', [fruitName]);
   }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:Text('${widget.fruitName} 페이지') ),
        body: Builder(builder: (BuildContext context) {
          return  GestureDetector(
            onTap: () => {
              sendToNative(widget.fruitName)
            },
            child: Center(child:
              Text("${widget.fruitName}"),),
          );
    })); //WebViewWidget(controller: _controller));
  }
}
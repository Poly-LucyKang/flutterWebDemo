
 import 'dart:js' as js; // JavaScript interop을 위한 패키지
import 'package:flutter/material.dart';
import 'package:webengage_flutter/webengage_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'model/NoticeModel.dart';

void main() {
  runApp(MyApp());
}
 // 과일 리스트
 final List<NoticeModel> fruits = [
   NoticeModel(
     title: "[7월 Book Report]",
     updateDate: "2023-07-10",
     content: "[7월 Book Report]"
 ),
   NoticeModel(
       title: "The 2023 SPEECH CONNTEST",
       updateDate: "2023-07-06",
       content: "The 2023 SPEECH CONNTEST"
   ),
   NoticeModel(
       title: "카카오 플러스 친구 OPEN",
       updateDate: "2023-07-06",
       content: "카카오 플러스 친구 OPEN"
   ),
   NoticeModel(
       title: "[숙제 확인 방법 안내]",
       updateDate: "2023-07-05",
       content: "[숙제 확인 방법 안내]"
   ),
   NoticeModel(
       title: "5월 Final Test 안내",
       updateDate: "2023-05-08",
       content: "5월 Final Test 안내"
   )];
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      color: Colors.white,
      home: FruitListPage(),
    );
  }
}

class FruitListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Row(
              children: [
                Expanded(flex: 9,child: Padding(padding: EdgeInsets.fromLTRB(20, 0, 10, 0), child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fruits[index].updateDate, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(fruits[index].title, style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),)
                  ],
                ),),),
                const Expanded(flex: 1,child: Align(alignment: Alignment.centerRight,child: Padding(padding: EdgeInsets.fromLTRB(10, 0, 20, 0), child: Icon(Icons.arrow_forward_ios_sharp),),))
              ],
            ),
            onTap: () {
              // 상세 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FruitDetailPage(fruitName: fruits[index].content),
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
     try {
       // 네이티브 앱에 메서드 호출
       js.context.callMethod('sendFruitName', [fruitName]);
       print('[KHJ] Successfully called native method with fruit: $fruitName');
     } catch (e) {
       // 호출이 실패했을 때 오류 로그 출력
       print('[KHJ] Error calling native method: $e');
     }
   }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(builder: (BuildContext context) {
          return  GestureDetector(
            onTap: () => {
              sendToNative(widget.fruitName)
            },
            child: Container(
              color: Colors.white,
              child: Center(child:
              Text("${widget.fruitName}"),
            )),
          );
    })); //WebViewWidget(controller: _controller));
  }
}
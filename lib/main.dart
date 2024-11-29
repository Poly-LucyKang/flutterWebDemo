import 'package:flutter/material.dart';

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

class FruitDetailPage extends StatelessWidget {
  final String fruitName;

  // 생성자에서 과일 이름을 받음
  FruitDetailPage({required this.fruitName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$fruitName 페이지'),
      ),
      body: Center(
        child: Text(
          '♡ ♥ $fruitName ♥ ♡',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

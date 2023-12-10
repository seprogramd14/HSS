import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSS',
      home: MyPage(),
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}


class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  int _selectedIndex = 0;

  final List<Widget> _navIndex = [
    MyHome(),
    MyInfoPage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navIndex.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        height: 74,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                  color: Color(0xff99CFFF),
                  width: 6,
                )
            )
        ),
        child: BottomNavigationBar(
          fixedColor: Color(0xff99CFFF),
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onNavTapped,
        ),
      ),
    );
  }
}


// 메인페이지
class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff99CFFF),
        leading: Icon(Icons.home, size: 37, ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings, size: 30,)
          ),
        ],
      ),
      body: Center(
        child: InkWell(
          child: Container(
            width: 160,
            height: 130,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: const [
                Icon(Icons.camera_alt, size: 91,),
                Text('실시간 캠 확인', style: TextStyle(fontSize: 25),),
              ],
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}


// 마이페이지
class MyInfoPage extends StatelessWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Color(0xffD3EAFF),
      minimumSize: Size(234, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff99CFFF),
        leading: Icon(Icons.person, size: 37, ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings, size: 30,)
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 111,
              height: 111,
              margin: EdgeInsets.fromLTRB(0, 28, 0, 0),
              decoration: BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(Icons.person, size: 50,),
            ),
            Text(
              '(유저 이름)',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 28),
            ElevatedButton(
              style: style,
              onPressed: () {},
              child: Text('자신의 사진 설정', style: TextStyle(color: Colors.black, fontSize: 24),),
            ),
            SizedBox(height: 18),
            ElevatedButton(
              style: style,
              onPressed: () {},
              child: Text('로그아웃', style: TextStyle(color: Color(0xffFF4040), fontSize: 24),),
            ),
            SizedBox(height: 18),
            ElevatedButton(
                style: style,
                onPressed: () {},
                child: Text('회원 탈퇴', style: TextStyle(color: Color(0xffff0000), fontSize: 24),)
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_contact/join.dart';
import 'package:flutter_contact/login.dart';
import 'package:flutter_contact/setting.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'homepage.dart'; // 메인 화면
import 'log.dart'; // 로그 화면
import 'family.dart'; // 가족 화면
import 'user.dart'; // 유저 화면


void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSS',
      home: Join(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/settings': (context) => Setting(), // 설정 버튼
        '/familycreate': (context) => FamilyCreate(),
        '/familyjoin': (context) => FamilyJoin(),
        '/login': (context) => Login(),
        '/mainpage': (context) => MainPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _navIndex = [
    HomePage(),
    LogPage(),
    FamilyPage(),
    MyInfoPage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 설명 다 써놓기
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navIndex.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xff99cfff),
              width: 5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          fixedColor: Color(0xff99cfff),
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.house), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: '로그 확인'),
            BottomNavigationBarItem(
                icon: Icon(Icons.family_restroom), label: '가족 생성/참여'),
            BottomNavigationBarItem(icon: Icon(Icons.person_2), label: '마이페이지')
          ],
          currentIndex: _selectedIndex,
          onTap: _onNavTapped,
        ),
      ),
    );
  }
}

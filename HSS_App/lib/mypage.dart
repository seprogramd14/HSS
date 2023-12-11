import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';

class MyAppPage extends StatefulWidget {
  const MyAppPage({super.key});

  @override
  State<MyAppPage> createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      routes: {
        '/LogIn': (context) => const LogIn(),
        '/SignUp': (context) => const SignUp(),
        '/Home': (context) => const MyAppPage(),
      },
      title: 'HSS',
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff99CFFF),
            title: Text('HSS', style: TextStyle(color: Colors.white),),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings, size: 30,)
              ),
            ],
          ),
          body: IndexedStack(
            index: _index,
            children: const [MyHome(), MyInfoPage()],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
            ],
            currentIndex: _index,
            onTap: (newindex) {
              print('${newindex}');
              setState(() {
                _index = newindex;
              });
            },
          ),
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
    return Center(
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
    return Center(
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
            onPressed: () {
              Navigator.of(context).pushNamed('/LogIn');
            },
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
    );
  }
}
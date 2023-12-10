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
      home: SignUp(),
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}

// 네이게이터 바
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

// 로그인 페이지
class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        width: 3,
        color: Color(0xffD3EAFF),
      ),
    );

    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Color(0xffD3EAFF),
      minimumSize: Size(100, 50),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff99CFFF),
        title: Text('로그인', style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 57),
            Image.asset('Image/Logo.jpg'),
            Container(
              width: 234,
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  enabledBorder: border,
                  focusedBorder: border,
                  labelText: '유저 이름',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              width: 234,
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 19, 0, 0),
              child: TextField(
                obscureText: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  enabledBorder: border,
                  focusedBorder: border,
                  labelText: '비밀번호',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 11, 0, 0),
              child: Text(
                '회원가입을 아직 안하셨나요?',
                style: TextStyle(
                  color: Color(0xff0075ff),
                  fontSize: 10,
                ),
              ),
            ),
            Container(
              width: 200,
              height: 45,
              margin: EdgeInsets.fromLTRB(0, 49, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: Text('로그인', style: TextStyle( color: Colors.black, fontSize: 15),)
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: Text('취소', style: TextStyle( color: Colors.black, fontSize: 15),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 회원가입 페이지
class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        width: 3,
        color: Color(0xffD3EAFF),
      ),
    );

    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Color(0xffD3EAFF),
      minimumSize: Size(100, 50),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff99CFFF),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 57),
            Image.asset('Image/Logo.jpg'),
            Container(
              width: 234,
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  enabledBorder: border,
                  focusedBorder: border,
                  labelText: '유저 이름',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              width: 234,
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 19, 0, 0),
              child: TextField(
                obscureText: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  enabledBorder: border,
                  focusedBorder: border,
                  labelText: '비밀번호',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              width: 234,
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 19, 0, 0),
              child: TextField(
                obscureText: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  enabledBorder: border,
                  focusedBorder: border,
                  labelText: '비밀번호 확인',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 45,
              margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
              child: ElevatedButton(
                  style: style,
                  onPressed: () {},
                  child: Text('회원가입', style: TextStyle( color: Colors.black, fontSize: 18),)
              ),
            )
          ],
        ),
      ),
    );
  }
}

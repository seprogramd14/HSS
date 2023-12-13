import 'package:flutter/material.dart';

// 로그인 페이지
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
        automaticallyImplyLeading: false,
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
              child: TextButton(
                child: Text(
                  '회원가입을 아직 안하셨나요?',
                  style: TextStyle(
                    color: Color(0xff0075ff),
                    fontSize: 10,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/SignUp');
                },
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
                      onPressed: () {
                        Navigator.of(context).pushNamed('/Home');
                      },
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
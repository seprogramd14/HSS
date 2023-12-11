import 'package:flutter/material.dart';

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
                  onPressed: () {
                    Navigator.of(context).pushNamed('/LogIn');
                  },
                  child: Text('회원가입', style: TextStyle( color: Colors.black, fontSize: 18),)
              ),
            )
          ],
        ),
      ),
    );
  }
}

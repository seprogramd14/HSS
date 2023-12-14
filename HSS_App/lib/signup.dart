import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class User {
  late final String username;
  late final String password;
  late final String passwordCheck;

  User({this.username = '', this.password = '', this.passwordCheck = ''});

  factory User.fromJson(Map<String, dynamic> userMap) {
    return User(
      username: userMap['username'],
      password: userMap['password'],
      passwordCheck: userMap['passwordCheck'],
    );
  }
}

Future<User> signup() async {
  final response = await http.get(Uri.parse("http://127.0.0.1:8000/user/sign-up"));

  if (response.statusCode == 201) {
    final userMap = json.decode(response.body);
    return User.fromJson(userMap);
  }

  throw Exception('데이터 수신 실패');
}


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordCheck = TextEditingController();

  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode passwordCheckFocus = FocusNode();

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
                controller: username,
                focusNode: usernameFocus,
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
                controller: password,
                focusNode: passwordFocus,
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
                controller: passwordCheck,
                focusNode: passwordCheckFocus,
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
                    print(username.text);
                    print(password.text);
                    print(passwordCheck.text);
                    Navigator.of(context).pushNamed('/LogIn');
                  },
                  child: Text('회원가입',
                    style: TextStyle(color: Colors.black, fontSize: 18),)
              ),
            ),
            // FutureBuilder(
            //   future: signup(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       showDialog(
            //         context: context,
            //         barrierDismissible: false,
            //         builder: (BuildContext ctx) {
            //           return AlertDialog(
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10.0),
            //             ),
            //             title: Column(
            //               children: const [
            //                 Text('회원가입에 성공했습니다.'),
            //               ],
            //             ),
            //             content: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: const [
            //                 Text('로그인 화면으로 돌아갑니다.'),
            //               ],
            //             ),
            //             actions: [
            //               TextButton(
            //                   onPressed: () {
            //                     Navigator.pop(context);
            //                   },
            //                   child: Text('확인')
            //               )
            //             ],
            //           );
            //         },
            //       );
            //     } else if (snapshot.hasError) {
            //       return Text('${snapshot.error}');
            //     }
            //     return CircularProgressIndicator();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';


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

  // 서버로 데이터 보내기
  Future<Map> signUp() async {
    final Map<String, dynamic> signUpInfo = {
      "username": username.text,
      "password": password.text,
      "password_check": passwordCheck.text,
    };
    final response = await Dio().post(
        'http://127.0.0.1:8000/user/sign-up',
        data: jsonEncode(signUpInfo),
    );
    return response.data;
  }

  // 화면에 alert 창 띄우기
  void flutterDialog(String title, String text) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              title: Column(
                children: [
                  Text(title),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (title == "회원가입 성공") {
                      Navigator.of(context).pushNamed('/LogIn');
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text("확인"),
                )
              ],
            );
          },
      );
  }

  @override
  Widget build(BuildContext context) {
    // 테두리 스타일
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        width: 3,
        color: Color(0xffD3EAFF),
      ),
    );

    // 버튼 스타일
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: Color(0xffD3EAFF),
      minimumSize: Size(100, 50),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
    );

    // 회원가입 화면
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
            SizedBox(
              child: TextButton(
                child: Text(
                  '로그인 화면으로 돌아가기',
                  style: TextStyle(
                    color: Color(0xff0075ff),
                    fontSize: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/LogIn');
                },
              ),
            ),
            Container(
              width: 200,
              height: 45,
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: ElevatedButton(
                style: style,
                child: Text(
                  '회원가입',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                onPressed: () async {
                  try {
                    // 회원가입 함수 호출
                    var result = await signUp();
                    // UI 업데이트
                    print(result);
                    flutterDialog("회원가입 성공", "회원가입에 성공했습니다.");
                  } catch (error) {
                    // 오류 처리
                    if (error is DioException) {
                      if (error.response != null) {
                        // 서버 응답이 있는 경우
                        print("Server responded with: ${error.response!.data['detail']}");
                        flutterDialog("회원가입 실패", error.response!.data['detail']);
                      } else {
                        // 서버 응답이 없는 경우
                        print("Connection failed: ${error.message}");
                        flutterDialog("회원가입 오류", "서버 에러");
                      }
                    } else {
                      // 다른 종류의 오류 처리
                      print("Unexpected error: $error");
                      flutterDialog("오류", "알 수 없는 오류 발생");
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
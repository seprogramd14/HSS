import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';


// 로그인 페이지
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  // 서버로 데이터 보내기
  Future<Map> logIn() async {
    final Map<String, dynamic> signUpInfo = {
      "username": username.text,
      "password": password.text,
    };
    final response = await Dio().post(
      'http://127.0.0.1:8000/user/log-in',
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
                if (title == "로그인 성공") {
                  Navigator.of(context).pushNamed('/Home');
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
                      onPressed: () async {
                        try {
                          // 회원가입 함수 호출
                          var result = await logIn();
                          // UI 업데이트
                          print(result);
                          flutterDialog("로그인 성공", "로그인에 성공했습니다.");
                        } catch (error) {
                          // 오류 처리
                          if (error is DioException) {
                            if (error.response != null) {
                              // 서버 응답이 있는 경우
                              print("Server responded with: ${error.response!.data['detail']}");
                              flutterDialog("로그인 실패", error.response!.data['detail']);
                            } else {
                              // 서버 응답이 없는 경우
                              print("Connection failed: ${error.message}");
                              flutterDialog("로그인 오류", "서버 에러");
                            }
                          } else {
                            // 다른 종류의 오류 처리
                            print("Unexpected error: $error");
                            flutterDialog("오류", "알 수 없는 오류 발생");
                          }
                        }
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
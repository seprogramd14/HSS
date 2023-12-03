import 'package:flutter/material.dart';
// import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  TextEditingController nickname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  FocusNode nicknameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode password1Focus = FocusNode();
  FocusNode password2Focus = FocusNode();

  void _register() async {
    try {
      final Map<String, dynamic> joinInfo = {
        "username": nickname.text,
        "email": email.text,
        "password1": password1.text,
        "password2": password2.text,
      };

      final response = await Dio().post(
      'http://127.0.0.1:8000/user/signup',
      data: jsonEncode(joinInfo),
      options: Options(
        headers: {
          "Content-Type" : "application/json"
        }
      )
    );

      if (response.statusCode == 204) {
        print('성공');
      } else {
        print('실패');
      }
    } catch (error) {
      print('오류');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HSS 회원가입'),
        backgroundColor: Color(0xff99cfff),
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                child: Theme(
                  data: ThemeData(
                      primaryColor: Color(0xff99cfff),
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                              color: Color(0xFF009688), fontSize: 15.0))),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Icon(
                          Icons.camera_rear_outlined,
                          size: 130,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          width: 250,
                          height: 53,
                          child: TextField(
                            controller: nickname,
                            focusNode: nicknameFocus,
                            cursorColor: Color.fromARGB(255, 0, 0, 0),
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff99cfff),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xFF009688),
                                ),
                              ),
                              labelText: '닉네임',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: 250,
                          height: 53,
                          child: TextField(
                            controller: email,
                            focusNode: emailFocus,
                            cursorColor: Color.fromARGB(255, 0, 0, 0),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff99cfff),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xFF009688),
                                ),
                              ),
                              labelText: '이메일',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: 250,
                          height: 53,
                          child: TextField(
                            controller: password1,
                            focusNode: password1Focus,
                            cursorColor: Color.fromARGB(255, 0, 0, 0),
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff99cfff),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xFF009688),
                                ),
                              ),
                              labelText: '비밀번호',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: 250,
                          height: 53,
                          child: TextField(
                            controller: password2,
                            focusNode: password2Focus,
                            cursorColor: Color.fromARGB(255, 0, 0, 0),
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xff99cfff),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color(0xFF009688),
                                ),
                              ),
                              labelText: '비밀번호 확인',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  primary: Color(0xffC9E6FF),
                                  minimumSize: Size(220, 50)),
                              onPressed: _register,
                              child: Text(
                                '회원가입',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(
    content: text,
    duration: Duration(seconds: 5),
    backgroundColor: Colors.red,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

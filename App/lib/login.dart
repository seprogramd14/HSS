import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();

  FocusNode idFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HSS 로그인'),
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
                          margin: EdgeInsets.only(top: 30),
                          width: 250,
                          height: 53,
                          child: TextField(
                            controller: id,
                            focusNode: idFocus,
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
                              labelText: '이메일',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          width: 250,
                          height: 53,
                          child: TextField(
                            controller: password,
                            focusNode: passwordFocus,
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
                        TextButton(
                            onPressed: () {
                              print('비밀번호 찾기');
                            },
                            child: Text('비밀번호를 잊어버렸나요?')),
                        TextButton(
                          onPressed: () {
                            print('회원가입');
                          },
                          child: Text('회원가입을 아직 안하셨나요?'),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  primary: Color(0xffC9E6FF),
                                  minimumSize: Size(100, 50)),
                              onPressed: () {
                                if (id.text == 'shtmdwns0@gmail.com' &&
                                    password.text == '1234') {
                                  Navigator.popAndPushNamed(
                                      context, '/mainpage');
                                } else if (id.text ==
                                        'shtmdwns0@gmail.com' &&
                                    password.text != '1234') {
                                  showSnackBar(context, Text('비밀번호가 틀렸습니다.'));
                                } else {
                                  showSnackBar(context, Text('이메일이 틀렸습니다.'));
                                }
                              },
                              child: Text(
                                '로그인',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  primary: Color(0xffC9E6FF),
                                  minimumSize: Size(100, 50)),
                              onPressed: () {
                                print('취소');
                              },
                              child: Text(
                                '취소',
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

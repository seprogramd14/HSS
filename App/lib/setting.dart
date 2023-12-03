import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool Switch_bool = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              width: 250,
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffc9e6ff),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '알림 설정',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  CupertinoSwitch(
                      value: Switch_bool,
                      activeColor: Color(0xFF1C8DF0),
                      onChanged: (bool? value) {
                        setState(() {
                          Switch_bool = value ?? false;
                        });
                      }),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  primary: Color(0xffC9E6FF),
                  minimumSize: Size(250, 50)),
              onPressed: () {
                print('비번 변경');
              },
              child: Text(
                '비번 변경',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

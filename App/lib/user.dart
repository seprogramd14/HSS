import 'package:flutter/material.dart';

class MyInfoPage extends StatelessWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: Icon(Icons.settings))
        ],
        backgroundColor: Color(0xff99cfff),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.person_2,
                size: 50,
              ),
            ),
            Text(
              '노승준 (이름칸임)',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    primary: Color(0xffC9E6FF),
                    minimumSize: Size(250, 50)),
                onPressed: () {
                  print('사진을 설정하는 버튼');
                },
                child: Text(
                  '자신의 사진 설정',
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    primary: Color(0xffC9E6FF),
                    minimumSize: Size(250, 50)),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Text(
                  '로그아웃',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                )),
          ],
        ),
      ),
    );
  }
}

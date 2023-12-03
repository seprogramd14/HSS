import 'package:flutter/material.dart';

// 가족 메인 페이지
class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('가족 생성 / 참여'),
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
        child: Container(
          width: 400,
          height: 300,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
          child: Column(children: [
            Container(
              width: 309,
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
              padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
              child: Text(
                '현재 당신은 (이름) 가족에 소속되어 있습니다.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Color(0xffC9E6FF),
                      minimumSize: Size(150, 150)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/familycreate');
                  },
                  child: Text(
                    '가족 생성',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(width: 35),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Color(0xffC9E6FF),
                      minimumSize: Size(150, 150)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/familyjoin');
                  },
                  child: Text(
                    '가족 참여',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

// 가족 생성 페이지

class FamilyCreate extends StatelessWidget {
  const FamilyCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('가족 생성'),
        backgroundColor: Color(0xff99cfff),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 입력 창 만들기
          Container(),
          Container()
        ],
      ),
    );
  }
}

// 가족 참여 페이지

class FamilyJoin extends StatelessWidget {
  const FamilyJoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('가족 참여'),
        backgroundColor: Color(0xff99cfff),
      ),
      body: Container(), // 코드 입력 창
    );
  }
}

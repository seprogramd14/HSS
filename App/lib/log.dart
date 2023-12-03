import 'package:flutter/material.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그 확인'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: Icon(Icons.settings))
        ],
        backgroundColor: Color(0xff99cfff),
      ),
      body: Container(
        child: Text('서버 연결하면 그 때 다시 만들어야 할 듯'),
      ),
    );
  }
}

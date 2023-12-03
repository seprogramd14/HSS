import 'button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈'),
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
        child: camera,
      ),
    );
  }
}

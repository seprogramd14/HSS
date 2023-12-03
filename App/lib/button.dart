import 'package:flutter/material.dart';

var camera = InkWell(
  onTap: () {
    print('카메라');
  },
  child: Container(
    width: 160,
    height: 120,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    child: Column(children: [
      Icon(
        Icons.camera_alt,
        size: 91,
      ),
      Text('실시간 캠 확인', style: TextStyle(fontSize: 20))
    ]),
  ),
);

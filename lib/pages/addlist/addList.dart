/**
 * 添加任务列表
 */

import 'package:flutter/material.dart';

class AddList extends StatefulWidget {
  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  bool hasList = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('添加')),
    );
  }
}
import 'package:flutter/material.dart';

class EntryDailog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('添加')),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('hello'),
        ),
      ),
    );
  }
}

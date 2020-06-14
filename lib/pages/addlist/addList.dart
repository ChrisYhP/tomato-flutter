/*
 * 添加任务列表
 * @author yanhoup
 */

import 'package:flutter/material.dart';

class AddList extends StatefulWidget {
  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  bool hasList = false;
  List<Map<String, dynamic>> _taskItems = [
    {
      'name': '学习',
      'icon': Icon(Icons.school),
      'isComplete': false,
    },
    {
      'name': '看电影',
      'icon': Icon(Icons.school),
      'isComplete': false,
    },
    {
      'name': '学习',
      'icon': Icon(Icons.school),
      'isComplete': false,
    },
    {
      'name': '看电影',
      'icon': Icon(Icons.school),
      'isComplete': true,
    },
  ];

  void onIconPress(item, index) {
    setState(() {
      _taskItems = _taskItems
          .asMap()
          .keys
          .map((f) => {
                ..._taskItems[f],
                'isComplete': f == index
                    ? !_taskItems[f]['isComplete']
                    : _taskItems[f]['isComplete']
              })
          .toList();
    });
    sortItems();
  }

  sortItems() {
    setState(() {
      _taskItems = [
        ..._taskItems.where((f) => !f['isComplete']),
        ..._taskItems.where((f) => f['isComplete'])
      ];
    });
  }

  Widget dismissBg() {
    return Container(
      alignment: Alignment.centerRight,
      color: Colors.redAccent[400],
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  void removItem(index) {
    setState(() {
      _taskItems.removeAt(index);
    });
  }

  void showSnack(context, removeItem, index) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('您删除了${removeItem['name']}'),
      action: SnackBarAction(
        label: '撤销',
        onPressed: () {
          setState(() {
            _taskItems.insert(index, removeItem);
            sortItems();
          });
        },
      ),
    ));
  }

  Widget genTaskList(context, index) {
    var item = _taskItems[index];
    return Container(
      key: Key('$index'),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[100],
              offset: Offset(0, 0),
              blurRadius: 4,
              spreadRadius: 4)
        ],
      ),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          showSnack(context, item, index);
          removItem(index);
        },
        background: dismissBg(),
        child: ListTile(
          leading: IconButton(
            onPressed: () => onIconPress(item, index),
            icon: item['isComplete']
                ? Icon(Icons.check_circle)
                : Icon(Icons.panorama_fish_eye),
          ), // <=== Example
          title: Text(
            item['name'],
            style: TextStyle(
                decoration:
                    item['isComplete'] ? TextDecoration.lineThrough : null),
          ),
        ),
      ),
    );
  }

  List<Widget> generateList(context) {
    var list =
        _taskItems.asMap().keys.map((f) => genTaskList(context, f)).toList();
    var hasCompleteItem = _taskItems.any((f) => f['isComplete']);
    var index = _taskItems.indexWhere((f) => f['isComplete']);
    if (hasCompleteItem) {
      list.insert(index, Text('已完成'));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('添加')),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: generateList(context),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        tooltip: '新增',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

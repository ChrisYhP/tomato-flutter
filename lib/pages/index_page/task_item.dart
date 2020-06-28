import 'package:flutter/material.dart';

class Task {
  Task({this.name, this.icon, this.isTap, this.controller});

  final String name;
  final Icon icon;
  bool isTap;
  AnimationController controller;
}

class TaskItem extends StatelessWidget {
  const TaskItem(
      {@required this.item, this.tileClick, this.removeItem, this.addItem});
  final Task item;
  final Function tileClick;
  final Function removeItem;
  final Function addItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ObjectKey(item),
      onTap: () => tileClick(item),
      title: Text(
        item.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '番茄时钟',
        style: TextStyle(fontSize: 14),
      ),
      leading: Container(
        width: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[item.icon],
        ),
      ),
      trailing: Container(
        key: ObjectKey(item),
        width: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AnimatedIcon(
                key: ObjectKey(item),
                icon: AnimatedIcons.play_pause,
                progress: item.controller),
            item.isTap
                ? Container(
                    child: PopupMenuButton(
                      offset: Offset(20, 40),
                      onSelected: (value) {
                        switch (value) {
                          case 'delete':
                            removeItem(item);
                            break;
                          case 'add':
                            addItem();
                            break;
                          default:
                        }
                      },
                      itemBuilder: (context) => <PopupMenuEntry<String>>[
                        PopupMenuItem(
                            height: 20,
                            value: 'add',
                            child: Text(
                              '新增',
                              style: TextStyle(fontSize: 12),
                            )),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          height: 20,
                          value: 'delete',
                          child: Text(
                            '删除',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

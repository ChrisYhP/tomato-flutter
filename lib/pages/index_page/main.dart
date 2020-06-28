import 'package:flutter/material.dart';
import 'package:tomato/audio.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tomato/pages/index_page/task_item.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  int index = 0;
  int currentPage = 0;

  Color blackBg = Hexcolor('#282828');

  List<Task> _taskItems = [
    Task(name: '学习', icon: Icon(Icons.school), isTap: false, controller: null)
  ];

  @override
  void initState() {
    super.initState();
    AudioPlay().init();
    AnimationController _controller = AnimationController(vsync: this)
      ..drive(Tween(begin: 0, end: 1))
      ..duration = Duration(milliseconds: 500)
      ..addStatusListener((AnimationStatus status) {
        print('global$status');
      });
    _taskItems = _taskItems.map((Task f) {
      f.controller = _controller;
      return f;
    }).toList();
  }

  /*
   * 新增列表 
   */
  void _addItem() {
    AnimationController _controller = AnimationController(vsync: this)
      ..drive(Tween(begin: 0, end: 1))
      ..duration = Duration(milliseconds: 500)
      ..addStatusListener((AnimationStatus status) {
        print('global$status');
      });
    Task task = Task(
        name: '学习',
        icon: Icon(Icons.school),
        isTap: false,
        controller: _controller);
    _listkey.currentState.insertItem(0, duration: Duration(milliseconds: 1000));
    _taskItems.insert(0, task);
    AudioPlay().play('mp3/add.mp3');
  }

  /*
   * 删除列表 
   */
  void _removeItem(Task item) {
    int index = _taskItems.indexOf(item);
    _taskItems.removeAt(index);
    _listkey.currentState.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        return SlideTransition(
          textDirection: TextDirection.rtl,
          position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
              .animate(
                  CurvedAnimation(curve: Curves.bounceIn, parent: animation)),
          child: TaskItem(item: item),
        );
      },
      duration: const Duration(milliseconds: 1000),
    );
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("您删除了${item.name}列表"),
      action: SnackBarAction(
        label: '撤销',
        onPressed: () {
          _taskItems.insert(index, item);
          _listkey.currentState.insertItem(index);
        },
      ),
    ));
    AudioPlay().play('mp3/remove.mp3');
  }

  void _tileClick(Task item) {
    setState(() {
      _taskItems = _taskItems.map((r) {
        r.isTap = r == item ? !r.isTap : false;
        return r;
      }).toList();
    });
    if (item.controller.status == AnimationStatus.dismissed) {
      item.controller.forward();
    } else {
      item.controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: AnimatedList(
          key: _listkey,
          initialItemCount: _taskItems.length,
          itemBuilder:
              (BuildContext context, int index, Animation<double> animation) =>
                  SlideTransition(
            position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                .animate(CurvedAnimation(
                    curve: Curves.easeInOutBack, parent: animation)),
            child: TaskItem(
              item: _taskItems[index],
              tileClick: _tileClick,
              removeItem: _removeItem,
              addItem: _addItem,
            ),
          ),
        )),
      ],
    );
  }
}

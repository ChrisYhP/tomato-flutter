import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'audio.dart';
import './pages/addlist/addList.dart';
import './animation//RotationXTransition.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: {"addList": (context) => AddList()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  
  int index = 0;
  
  int currentPage = 0;
  
  GlobalKey bottomNavigationKey = GlobalKey();
  
  List _taskItems = [
    {'name': '学习', 'icon': Icon(Icons.school), 'isTap': false},
    {'name': '工作', 'icon': Icon(Icons.work), 'isTap': false},
    {'name': '运动', 'icon': Icon(Icons.directions_run), 'isTap': false},
    {'name': '学习', 'icon': Icon(Icons.school), 'isTap': false},
    {'name': '工作', 'icon': Icon(Icons.work), 'isTap': false},
  ];

  List _buttonItems = [
    {'name': '任务', 'icon': Icons.school},
    {'name': '统计', 'icon': Icons.work},
    {'name': '打卡', 'icon': Icons.directions_run},
  ];

  @override
  void initState() {
    super.initState();
    AudioPlay().init();
  }

  // @override
  // void deactivate() async{
  //   print('结束');
  //   int result = await audioPlayer.release();
  //   if (result == 1) {
  //     print('release success');
  //   } else {
  //     print('release failed');
  //   }
  //   super.deactivate();
  // }

  /*
   * 新增列表 
   */
  void _addItem() {
    dynamic list = {'name': '22å', 'icon': Icon(Icons.school), 'isTap': false};
    _listkey.currentState.insertItem(0, duration: Duration(milliseconds: 1000));
    _taskItems.insert(0, list);
    AudioPlay().play('mp3/add.mp3');
  }

  /*
   * 删除列表 
   */
  void _removeItem(context, index) {
    dynamic itemToRemove = _taskItems[index];
      _taskItems.removeAt(index);

    _listkey.currentState.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
         print(animation.value);
        return SlideTransition(
          textDirection: TextDirection.rtl,
                        position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(CurvedAnimation(
                          curve: Curves.bounceIn,
                          parent: animation
                        )),
                        child: generateTask(context, index, itemToRemove),
          );
      },
      duration: const Duration(milliseconds: 1000),
    );
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("您删除了${itemToRemove['name']}列表"),
      action: SnackBarAction(
        label: '撤销',
        onPressed: () {
          _taskItems.insert(index, itemToRemove);
          _listkey.currentState.insertItem(index);
        },
      ),
    ));
    AudioPlay().play('mp3/remove.mp3');
  }

  /*
   * 生成任务列表
   */
  Widget generateTask(
      BuildContext context, int i, dynamic taskdata) {

    return ListTile(
    onTap: () {
      setState(() {
        this._taskItems = this
      ._taskItems
      .asMap()
      .keys
      .map((r) => ({
            ..._taskItems[i],
            'isTap': r == i ? !_taskItems[i]['isTap'] : false
          }))
      .toList();
      });
    },
    title: Text(
      taskdata['name'],
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
        children: <Widget>[taskdata['icon']],
      ),
    ),
    trailing: Container(
      width: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(child: child, scale: animation);
        },
        child: Icon(Icons.chevron_left,key: Key('${taskdata['isTap']}${i}'),), 
      ),
      taskdata['isTap']
          ? Container(
              child: PopupMenuButton(
                offset: Offset(20, 40),
                onSelected: (value) {
                  switch (value) {
                    case 'delete':
                      _removeItem(context, i);
                      break;
                    case 'add':
                      _addItem();
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

  /*
   * 底部导航按钮
   */
  Widget generateButton(i, buttonData) {
    return AnimatedSize(
          
          duration: Duration(milliseconds: 200),
          vsync: this,
          child: SizedBox(
          width: index == i ? 100 : 60,
          child: FlatButton.icon(
      color: index == i ? Colors.white : Colors.deepPurpleAccent[700],
      shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
      onPressed: () {
        setState(() {
          index = i;
        });
      },
      label: index == i
          ? Text(
              buttonData['name'],
              style: TextStyle(color: Colors.deepPurpleAccent[700]),
            )
          : Text(''),
      icon: Icon(
        buttonData['icon'],
        color: index == i ? Colors.deepPurpleAccent[700] : Colors.white,
      ),
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_taskItems.length);
    return Scaffold(
      appBar: AppBar(title: Text('任务')),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: AnimatedList(
              key: _listkey,
              initialItemCount: _taskItems.length,
              itemBuilder: (BuildContext context, int index,
                      Animation<double> animation) =>
                  SlideTransition(
                    position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(CurvedAnimation(
                      curve: Curves.easeInOutBack,
                      parent: animation
                    )),
                    child: generateTask(context, index, _taskItems[index]),
                  ) 
                  ,
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () => Navigator.pushNamed(context, 'addList'),
        tooltip: '新增',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurpleAccent[700],
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ..._buttonItems
                  .asMap()
                  .keys
                  .map((i) => generateButton(i, _buttonItems[i]))
                  .toList(),
              SizedBox(
                width: 60,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent[700],
              ),
            ),
            ListTile(
              title: Text('统计'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('分析'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('设置'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}

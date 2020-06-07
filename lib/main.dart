import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'audio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: {},
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  int index = 0;
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  // 音频

  List _taskItems = [
    {'name': '学习', 'icon': Icon(Icons.school)},
    {'name': '工作', 'icon': Icon(Icons.work)},
    {'name': '运动', 'icon': Icon(Icons.directions_run)},
    {'name': '待定', 'icon': Icon(Icons.disc_full)},
    {'name': '打篮球', 'icon': Icon(Icons.today)},
    {'name': '看书', 'icon': Icon(Icons.bubble_chart)},
    {'name': '即将到来', 'icon': Icon(Icons.disc_full)},
    {'name': '待定', 'icon': Icon(Icons.disc_full)},
    {'name': '打篮球', 'icon': Icon(Icons.today)},
    {'name': '看书', 'icon': Icon(Icons.bubble_chart)},
    {'name': '即将到来', 'icon': Icon(Icons.disc_full)},
    {'name': '待定', 'icon': Icon(Icons.disc_full)},
    {'name': '打篮球', 'icon': Icon(Icons.today)},
    {'name': '看书', 'icon': Icon(Icons.bubble_chart)},
    {'name': '即将到来', 'icon': Icon(Icons.disc_full)},
    {'name': '待定', 'icon': Icon(Icons.disc_full)},
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

  void _addItem() {
    dynamic list = {'name': '22å', 'icon': Icon(Icons.school)};
    _taskItems.insert(0, list);
    _listkey.currentState.insertItem(0);
    AudioPlay().play('mp3/add.mp3');
  }

  void _removeItem(index) {
    print(index);
    dynamic itemToRemove = _taskItems[index];
    _taskItems.removeAt(index);
    _listkey.currentState.removeItem(
      index,
      (BuildContext context, Animation<double> animation) =>
          generateTask(index, itemToRemove, animation),
      duration: const Duration(milliseconds: 250),
    );
    AudioPlay().play('mp3/remove.mp3');
  }

  Widget generateTask(int i, dynamic taskdata, Animation animation) {
    return ScaleTransition(
      scale: animation,
      child: ListTile(
        title: Text(
          taskdata['name'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '番茄时钟',
          style: TextStyle(fontSize: 14),
        ),
        leading: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[taskdata['icon']],
        ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            switch (value) {
              case 'delete':
                _removeItem(i);
                break;
              case 'add':
                break;
              default:
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            PopupMenuItem(
              value: 'add',
              child: ListTile(leading: Icon(Icons.add), title: Text('添加子任务')),
            ),
            PopupMenuDivider(),
            PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('删除'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget generateButton(i, buttonData) {
    return ButtonTheme(
      minWidth: 30,
      child: FlatButton.icon(
        color: index == i ? Colors.white : Colors.deepPurpleAccent[700],
        shape: index == i
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))
            : null,
        onPressed: () {
          setState(() {
            index = i;
          });
        },
        highlightColor: Colors.orangeAccent[100],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurpleAccent[700],
        child: Column(
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, 40),
              child: Container(
                width: double.infinity,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '下午',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: AnimatedList(
                key: _listkey,
                initialItemCount: _taskItems.length,
                itemBuilder: (BuildContext context, int index,
                        Animation<double> animation) =>
                    generateTask(index, _taskItems[index], animation),
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () => _addItem(),
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
              SizedBox(width: 60,)
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
      ),
    );
  }
}

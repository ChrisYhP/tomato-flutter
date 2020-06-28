import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomato/pages/entry_dailog/bloc/category_bloc.dart';
import 'package:tomato/pages/entry_dailog/entry_dailog.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tomato/pages/index_page/main.dart';
import 'package:tomato/widgets/bottom_navigator_item.dart';
import 'package:tomato/widgets/draw.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Color blackBg = Hexcolor('#282828');

  List<ButtonItem> _buttonItems = [
    ButtonItem(name: '任务', icon: Icons.school, isSelected: true),
    ButtonItem(name: '统计', icon: Icons.work, isSelected: false),
    ButtonItem(name: '打卡', icon: Icons.directions_run, isSelected: false),
  ];

  @override
  void initState() {
    super.initState();
  }

  void gotoAddList(context) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return EntryDailog();
        },
        fullscreenDialog: true));
  }

  void indexChange(ButtonItem i) {
    int index = _buttonItems.indexOf(i);
    setState(() {
      _currentIndex = index;
      _buttonItems = _buttonItems.map((e) {
        e.isSelected = i == e;
        return e;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('任务'), backgroundColor: blackBg),
        body: IndexedStack(
          index: _currentIndex,
          children: [IndexPage()],
          sizing: StackFit.expand,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () => gotoAddList(context),
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
                    .map((i) => BottomNavigatorButton(
                        item: i, indexChange: indexChange))
                    .toList(),
                SizedBox(
                  width: 60,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
        ),
        drawer: Draw());
  }
}

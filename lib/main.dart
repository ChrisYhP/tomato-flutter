import 'package:flutter/material.dart';

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
  int index = 0;
  List taskItems =  [
    {'name': '今天', 'icon': Icon(Icons.today)},
    {'name': '明天', 'icon': Icon(Icons.bubble_chart)},
    {'name': '即将到来', 'icon': Icon(Icons.disc_full)},
    {'name': '待定', 'icon': Icon(Icons.disc_full)},
  ];
  
  void _onPress() {
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.deepPurpleAccent[700],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('下午好', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w800),),
              ),
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(0, -40),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                  ),
                  child: ListView(
                    children: taskItems.map((f) => TaskItem(taskdata: f)).toList(),
                  ),
                ),
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: _onPress,
        tooltip: '新增',
        child: Icon(Icons.add, color: Colors.white,),
      ), 
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurpleAccent[700],
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: FlatButton.icon(
                  label: index == 0 ? Text('首页', style: TextStyle(color: Colors.deepPurpleAccent[700]),) : Text(''),
                  icon: Icon(Icons.add_alarm, color: Colors.deepPurpleAccent[700],),
                ),
              ), 
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: index == 1 ? Colors.white : Colors.deepPurpleAccent[700],
                  borderRadius: BorderRadius.circular(30)
                ),
                child: FlatButton.icon(
                  label: index == 1 ? Text('首页', style: TextStyle(color: Colors.deepPurpleAccent[700]),) : Text(''),
                  icon: Icon(Icons.add_alarm, color: Colors.white,),
                ),
              ),  
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: index == 1 ? Colors.white : Colors.deepPurpleAccent[700],
                  borderRadius: BorderRadius.circular(30)
                ),
                child: FlatButton.icon(
                  label: index == 1 ? Text('首页', style: TextStyle(color: Colors.deepPurpleAccent[700]),) : Text(''),
                  icon: Icon(Icons.add_alarm, color: Colors.white,),
                ),
              ),  
              SizedBox(width: 60,),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {

  const TaskItem({
    Key key,
    this.taskdata
  }) : super(key: key);

  final taskdata;

  @override
  Widget build(BuildContext context) {
    print(taskdata);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(children: <Widget>[
            taskdata['icon'],
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                taskdata['name'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                ),
              ),
            ),
          ],),
          Row(children: <Widget>[
            Text('12h'),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                '2', 
                style: TextStyle(
                  color: Colors.black87
                )
              ),
            )
          ],),
        ],
      )
    );
  }
}

// class ListView3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //下划线widget预定义以供复用。  
//     Widget divider1=Divider(color: Colors.blue,);
//     Widget divider2=Divider(color: Colors.green);
//     return ListView.separated(
//         itemCount: 100,
//         //列表项构造器
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(title: Text("$index"));
//         },
//         //分割器构造器
//         separatorBuilder: (BuildContext context, int index) {
//           return index%2==0?divider1:divider2;
//         },
//     );
//   }
// }
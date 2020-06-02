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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: ' Page'),
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
  int _counter = 0;
  
  void _onPress() {
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: 300
              ),
              child: Container(
                alignment: Alignment.center,
                color: Colors.redAccent,
                child: Container()
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Icon(Icons.today),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            '今天',
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
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPress,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Container()
          ),
          BottomNavigationBarItem(icon: Icon(Icons.av_timer), title: Container()),
          BottomNavigationBarItem(icon: Icon(Icons.face), title: Container()),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ButtonItem {
  ButtonItem({this.name, this.icon, this.isSelected});
  final String name;
  final IconData icon;
  bool isSelected;
}

class BottomNavigatorButton extends StatelessWidget {
  const BottomNavigatorButton(
      {@required this.item, @required this.indexChange});

  final ButtonItem item;
  final Function indexChange;

  @override
  Widget build(BuildContext context) {
    Color activeColor = Colors.deepPurpleAccent[700];
    Color inactiveColor = Colors.white;
    bool isSelected = item.isSelected;
    return AnimatedContainer(
      width: isSelected ? 120 : 60,
      height: 40,
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
          color: isSelected ? inactiveColor : activeColor,
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        child: InkWell(
          onTap: () => indexChange(item),
          child: Container(
            width: isSelected ? 100 : 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                    color:
                        isSelected ? activeColor.withOpacity(1) : inactiveColor,
                  ),
                  child: Icon(item.icon),
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          color: activeColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        child: Text(item.name),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

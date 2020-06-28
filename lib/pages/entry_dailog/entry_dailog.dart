import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomato/pages/entry_dailog/bloc/category_bloc.dart';
import 'package:tomato/utils/colors.dart';

class RadioItem {
  const RadioItem({
    this.activeColor,
    this.value,
  });
  final Color activeColor;
  final Color value;
}

class EntryDailog extends StatefulWidget {
  @override
  _EntryDailogState createState() => _EntryDailogState();
}

class _EntryDailogState extends State<EntryDailog> {
  Color _groupValue = MyColors.radioRed;
  String textValue;

  List<RadioItem> _radioItems = [
    RadioItem(
      activeColor: MyColors.radioRed,
      value: MyColors.radioRed,
    ),
    RadioItem(
      activeColor: MyColors.radioBlue,
      value: MyColors.radioBlue,
    ),
    RadioItem(activeColor: MyColors.radioPink, value: MyColors.radioPink),
    RadioItem(activeColor: MyColors.radioGreen, value: MyColors.radioGreen),
    RadioItem(activeColor: MyColors.radioOrange, value: MyColors.radioOrange),
  ];

  List<Theme> renderRadioItems() {
    return _radioItems
        .map(
          (e) => Theme(
            data: Theme.of(context)
                .copyWith(unselectedWidgetColor: e.activeColor),
            child: Radio(
              hoverColor: e.activeColor,
              activeColor: e.activeColor,
              groupValue: _groupValue,
              value: e.value,
              onChanged: (value) {
                setState(() {
                  _groupValue = e.value;
                });
              },
            ),
          ),
        )
        .toList();
  }

  _onTextSubmit(BuildContext context) async {
    //ignore: close_sinks
    CategoryBloc categoryBloc = BlocProvider.of<CategoryBloc>(context);
    CategoryItem item = CategoryItem(name: textValue, color: Colors.red);
    categoryBloc.add(CategoryEvent(item: item));
  }

  void _onTextChange(String value) {
    setState(() {
      textValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    CategoryBloc categoryBloc = BlocProvider.of<CategoryBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('添加'),
        backgroundColor: _groupValue,
        actions: <Widget>[
          FlatButton(
              onPressed: () => _onTextSubmit(context),
              child: Text(
                '保存',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ))
        ],
      ),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextField(
                autofocus: true,
                maxLines: 4,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: MyColors.radioGreen.withOpacity(0.3)),
                onChanged: (value) => _onTextChange(value),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: renderRadioItems(),
                ),
              ),
              BlocBuilder(
                  bloc: categoryBloc,
                  builder: (BuildContext context, AddCategoryState state) {
                    return Container(child: Text('ppp${state.list[0].name}'));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

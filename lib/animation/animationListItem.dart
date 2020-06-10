import 'package:flutter/material.dart';


class AnimationListItem extends StatefulWidget {
  final Widget child;

  AnimationListItem(this.child);

  @override
  _AnimationListItemState createState() => _AnimationListItemState();
}

class _AnimationListItemState extends State<AnimationListItem> {
  bool _lock = false;
  
  @override
  void initState() { 
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      setState(() {
        _lock = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1500),
      opacity: _lock ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: Duration(microseconds: 700),
        curve: Curves.ease,
        padding: _lock ? EdgeInsets.zero : EdgeInsets.only(top: MediaQuery.of(context).size.height),
        child: widget.child,
      ),
    );
  }
}
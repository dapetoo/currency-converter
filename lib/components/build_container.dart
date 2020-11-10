import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  final Widget cardChild;

  ReusableContainer({@required this.cardChild});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.grey.shade200, width: 3),
        ),
        child: cardChild);
  }
}

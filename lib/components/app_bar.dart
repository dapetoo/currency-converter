import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.sort,
            color: Color(0xFF23DEA6),
            size: 40,
          ),
          onPressed: () {},
        ),
        Text(
          'Currency Calculator',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            //color: Color(0xFF23DEA6),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

Row buildBottomRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Mid-market exchange rate at 13:31 UTC',
        style: TextStyle(
          fontSize: 10,
          decoration: TextDecoration.underline,
          color: Colors.blue,
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.error,
        color: Colors.grey,
      )
    ],
  );
}
import 'package:flutter/material.dart';

Widget buildErrorWidget(String error) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(error, style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold
        ),)
      ],
    ),
  );
}
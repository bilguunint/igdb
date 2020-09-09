import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildLoadingWidget() {
  return Center(
    child: Column(
      children: [
        CupertinoActivityIndicator()
      ],
    ),
  );
}
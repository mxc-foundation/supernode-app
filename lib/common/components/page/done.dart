import 'package:flutter/material.dart';
import 'package:supernodeapp/common/configs/images.dart';

Widget done({bool success = true}){
  return Center(
    child: Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Icon(
        success ? Icons.done : Icons.info_outline,
        color: success ? Colors.green : Colors.blue,
        size: 80,
      )
    ),
  );
}
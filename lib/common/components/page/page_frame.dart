import 'package:flutter/material.dart';

Widget pageFrame({BuildContext context,List<Widget> children,EdgeInsetsGeometry padding}){
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Container(
      constraints: BoxConstraints.expand(),
      padding: const EdgeInsets.only(top: 20.0, left: 20.0,right: 20.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 239, 242),
      ),
      child: ListView(
        children: [
          Container(
            padding: padding != null ? padding : const EdgeInsets.all(20.0),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 20
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(26, 0, 0, 0),
                  offset: Offset(0, 2),
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children
            )
          )
        ]
      )
    )
  );
}
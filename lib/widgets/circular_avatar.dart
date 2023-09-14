import 'package:flutter/material.dart';

Widget avatar(String url, {double? radius}) {
  return CircleAvatar(
    radius: radius ?? 40,
    backgroundImage: const NetworkImage("https://thinksport.com.au/wp-content/uploads/2020/01/avatar-.jpg"),
    backgroundColor: Colors.white,
    child: Image.network(url),
  );
}
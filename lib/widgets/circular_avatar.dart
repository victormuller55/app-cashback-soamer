import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:flutter/material.dart';

Widget avatar(String url, {double? radius}) {
  return appContainer(
    radius: BorderRadius.circular(360),
    border: Border.all(color: Colors.white, width: 3),
    child: CircleAvatar(
      radius: radius ?? 40,
      backgroundImage: const NetworkImage("https://thinksport.com.au/wp-content/uploads/2020/01/avatar-.jpg"),
      backgroundColor: Colors.white,
      foregroundImage: NetworkImage(url),
    ),
  );
}
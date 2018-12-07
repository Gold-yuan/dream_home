import 'dart:math';

import 'package:flutter/material.dart';

main() {
  var rng = new Random();
  for (var i = 0; i < 10; i++) {
    print(rng.nextInt(4));
  }
}

test() {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Image from Network"),
    ),
    body: new Container(
        child: new Column(
      children: <Widget>[
        // Load image from network

        new Image.network(
            'https://flutter.io/images/flutter-mark-square-100.png'),
      ],
    )),
  );
}

import 'dart:io';

import 'package:flutter/material.dart';

class Imageviewer extends StatelessWidget {
  const Imageviewer({Key? key, this.image}) : super(key: key);
  final dynamic image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(tag: image, child: Image.file(File(image.toString()))),
      ),
    );
  }
}

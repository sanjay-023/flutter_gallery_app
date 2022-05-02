import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sample_gallery/image_view_screen.dart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Directory? directory;
  File? image;
  List<String> listImagePath = [];
  @override
  void initState() {
    super.initState();
    Directory dir = Directory.fromUri(Uri.parse(
        '/storage/emulated/0/Android/data/com.example.sample_gallery/files'));

    _fetchFiles(dir);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 68, 120),
        centerTitle: true,
        title: const Text('Gallery'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 5, 70, 122),
        onPressed: () async {
          var result =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (result == null) {
            //print("image null");
            return;
          }
          image = File(result.path);
          directory = await getExternalStorageDirectory();
          //print(directory!.path);
          await image!.copy('${directory!.path}/${DateTime.now()}.jpg');
          //print(str);
          Directory dir = directory!;
          _fetchFiles(dir);

          setState(() {});
        },
        child: const Icon(Icons.add_a_photo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: listImagePath.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 2),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => Imageviewer(
                              image: listImagePath[index],
                            )));
                  },
                  child: Hero(
                    tag: listImagePath[index],
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(File(listImagePath[index])))),
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }

  _fetchFiles(Directory dir) async {
    listImagePath.clear();
    var value = await dir.list().toList();
    print('hello$value');
    for (int i = 0; i < value.length; i++) {
      if (value[i]
              .path
              .substring((value[i].path.length - 4), (value[i].path.length)) ==
          ".jpg") {
        listImagePath.add(value[i].path);
      }
    }
    setState(() {});
    //print(listImagePath);
  }
}

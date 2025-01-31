import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  UploadImageState createState() => UploadImageState();
}

class UploadImageState extends State<UploadImage> {
  File? _image;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    // Substitua 'http://seu-pocketbase-url/api/files' pelo endpoint correto do seu PocketBase
    var dio = Dio();
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(_image!.path,
          filename: basename(_image!.path)),
    });

    try {
      Response response =
          await dio.post('http://solutil.com.br/api/files', data: formData);
      debugPrint(response.data); // Imprima a resposta do PocketBase
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(2.0),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          IconButton(
            onPressed: _pickImage,
            icon: Icon(Icons.image_search_outlined),
          ),
          if (_image != null) Image.file(_image!),
          IconButton(
            onPressed: _uploadImage,
            icon: Icon(Icons.upload),
          ),
        ],
      ),
    );
  }
}

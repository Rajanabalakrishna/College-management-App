


import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,String text)

{
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(text)));
}

Future<FilePickerResult?>pickImage() async
{
  final file=await FilePicker.platform.pickFiles(type: FileType.media);
  if(file!=null)
    {
      return file;
    }
}
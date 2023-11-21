import 'dart:io';
import 'package:flutter/material.dart';
import './widgets/image_picker.dart';

class Homescreen extends StatefulWidget {
  static const routeName = '/add-places';

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  // void _savedPlace() {
  //   if (_titleController.text.isEmpty ||
  //       _pickedImage == null ||
  //       _pickedLocation == null) {
  //     return;
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add a new place',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          elevation: 8,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      ImageInput(_selectImage),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )),
            ]));
  }
}

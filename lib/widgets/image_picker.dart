import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  String _selectedShape = 'Rectangle'; // Default shape

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery, maxWidth: 600);

    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 25),

      // ElevatedButton to trigger image selection
      ElevatedButton(
        onPressed: _takePicture,
        child: Text(
          'Choose from Device',
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
        ),
      ),

      SizedBox(height: 25),

        // Shape selection dropdown
        DropdownButton<String>(
          value: _selectedShape,
          items: [
            DropdownMenuItem<String>(
              child: Text('Rectangle'),
              value: 'Rectangle',
            ),
            DropdownMenuItem<String>(
              child: Text('Square'),
              value: 'Square',
            ),
            DropdownMenuItem<String>(
              child: Text('Circle'),
              value: 'Circle',
            ),
            DropdownMenuItem<String>(
              child: Text('Heart'),
              value: 'Heart',
            ),
            DropdownMenuItem<String>(
              child: Text('Original'),
              value: 'Original',
            ),
          ],
          onChanged: (newShape) {
            setState(() {
              _selectedShape = newShape!;
            });
          },
        ),

        SizedBox(height: 25),

        // Image container with shape applied
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? _renderImageWithSelectedShape() // Apply shape-specific mask or clip path
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
      ],
    );
  }

  Widget _renderImageWithSelectedShape() {
    switch (_selectedShape) {
      case 'Rectangle':
        return Image.file(
          _storedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
        );

      case 'Square':
        return ClipRect(
          child: Image.file(
            _storedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        );

      case 'Circle':
        return ClipOval(
          child: Image.file(
            _storedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        );

      case 'Heart':
 case 'Heart':
  return ClipPath(
    clipper: HeartClipper(),
    child: Image.file(
      _storedImage!,
      fit: BoxFit.cover,
      width: double.infinity,
    ),
  );


      default:
        return Image.file(
          _storedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
        );
    }
  }
}


class HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(size.width / 2, size.height / 5);

    path.cubicTo(
      size.width / 2,
      size.height / 5 - 30,
      size.width / 2 - 40,
      size.height / 5 - 80,
      size.width / 2 - 80,
      size.height / 5 - 80,
    );

    path.cubicTo(
      size.width / 2 - 120,
      size.height / 5 - 80,
      size.width / 2 - 120,
      size.height / 5 - 40,
      size.width / 2 - 120,
      size.height / 5,
    );

    path.cubicTo(
      size.width / 2 - 120,
      size.height / 5 + 40,
      size.width / 2 - 80,
      size.height / 5 + 80,
      size.width / 2,
      size.height / 5 + 120,
    );

    path.cubicTo(
      size.width / 2 + 80,
      size.height / 5 + 80,
      size.width / 2 + 120,
      size.height / 5 + 40,
      size.width / 2 + 120,
      size.height / 5,
    );

    path.cubicTo(
      size.width / 2 + 120,
      size.height / 5 - 40,
      size.width / 2 + 80,
      size.height / 5 - 80,
      size.width / 2,
      size.height / 5 - 120,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

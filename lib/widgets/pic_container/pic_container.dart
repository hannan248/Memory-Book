import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PicContainer extends StatefulWidget {
  final void Function(File?) onImageSelected;

  const PicContainer({
    super.key,
    required this.onImageSelected,
  });

  @override
  State<PicContainer> createState() => _PicContainerState();
}

class _PicContainerState extends State<PicContainer> {
  File? _selectedImage;

  Future<void> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
      widget.onImageSelected(_selectedImage);
    });
  }

  Future<void> getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
      widget.onImageSelected(_selectedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('No Image Selected'),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => getImageFromCamera(),
              icon: const Icon(Icons.camera_alt),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () => getImageFromGallery(),
              icon: const Icon(Icons.filter),
            ),
          ],
        ),
      ],
    );
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: () => getImageFromCamera(),
        onLongPress: () => getImageFromGallery(),
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.fill,
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: content,
    );
  }
}

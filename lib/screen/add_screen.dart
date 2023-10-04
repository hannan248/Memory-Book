import 'dart:io';
import 'package:flutter/material.dart';
import 'package:memory_book/models/data_models.dart';
import 'package:memory_book/widgets/pic_container/pic_container.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({
    super.key,
    required this.onAdd,
  });

  final Function(DataModel item) onAdd;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  File? selectImage;
  String enterName='';
  String description='';
  final _formKey = GlobalKey<FormState>();
  void saveButton() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    if(selectImage==null)
      {
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:

            Text('add Picture'),

        ));
        return;
      }
    widget.onAdd(DataModel(title:enterName, description: description, image:selectImage!));
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your Memory'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key:_formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length >= 10) {
                      return 'Must add valid value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    enterName = value!;
                  },
                  maxLength: 10,
                  decoration:
                      const InputDecoration(hintText: 'Enter your title'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length >= 10) {
                      return 'Must add valid value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    description = value!;
                  },
                  maxLength: 50,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
                const SizedBox(
                  height: 40,
                ),
                PicContainer(
                  onImageSelected: (File? selectedImage) {
                    setState(() {
                      selectImage = selectedImage;
                    });
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: ()=>saveButton(),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

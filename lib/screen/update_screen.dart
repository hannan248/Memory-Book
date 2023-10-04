import 'package:flutter/material.dart';
import 'package:memory_book/models/data_models.dart';

class EditScreen extends StatefulWidget {
  final DataModel item;
  final Function(DataModel) onUpdate;

  const EditScreen({super.key, required this.item, required this.onUpdate});

  @override
  State <EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.item.title);
    descriptionController = TextEditingController(text: widget.item.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void updateItem() {
    final updatedItem = DataModel(
      title: titleController.text,
      description: descriptionController.text,
      image: widget.item.image, // Preserve the image if needed
    );

    widget.onUpdate(updatedItem);

    Navigator.pop(context); // Close the EditScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: updateItem,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

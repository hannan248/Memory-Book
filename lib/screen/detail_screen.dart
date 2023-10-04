import 'package:flutter/material.dart';
import 'package:memory_book/models/data_models.dart';

class DetailScreen extends StatelessWidget {
  final DataModel item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.file(
                  item.image,
                  fit: BoxFit.cover,
                ),

                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Description: ${item.description}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                // Add any other details you want to display
              ],
            ),
          ),
        ),
      ),
    );
  }
}

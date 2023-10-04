import 'dart:io';

import 'package:uuid/uuid.dart';
var uuid=const Uuid();
class DataModel {
  final String id;
  final String title;
  final String description;
  final File image;
  bool isDescriptionVisible;

  DataModel(
      {required this.title,
        required this.description,
        required this.image,
        this.isDescriptionVisible = false,
      }):id=uuid.v4();
  // Deserialize from JSON
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      title: json['title'],
      description: json['description'],
      image: File(json['image']),
    );
  }
    // Serialize to JSON
    Map<String, dynamic> toJson() {
      return {
        'id': id,
        'title': title,
        'description': description,
        'image': image.path,
      };
    }

  }
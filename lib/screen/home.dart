import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:memory_book/models/data_models.dart';
import 'package:memory_book/screen/add_screen.dart';
import 'package:memory_book/screen/detail_screen.dart';
import 'package:memory_book/screen/update_screen.dart';
import 'package:memory_book/widgets/drawer.dart';
import 'package:memory_book/widgets/list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<DataModel> addedItem = [];
  final List<DataModel> favItemList = [];

  final String itemsKey = "added_items"; // Key to store the added items

  @override
  void initState() {
    super.initState();

    // Load previously added items from SharedPreferences when the app starts
    loadItems();
  }

  void updateItem(int index, DataModel updatedItem) {
    setState(() {
      addedItem[index] =
          updatedItem; // Replace the old item with the updated one
      saveItems(); // Save the updated list of items
    });
  }

  void favItem(int index) {
    setState(() {
      favItemList.add(addedItem[index]);
    });
  }

  void editItem(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            EditScreen(
              item: addedItem[index],
              onUpdate: (updatedItem) {
                // Handle item update and save it
                updateItem(index, updatedItem);
              },
            ),
      ),
    );
  }

  void addItem(DataModel item) {
    setState(() {
      addedItem.add(item);
      saveItems(); // Save the updated list of items
    });
  }

  void removeItem(int index) {
    setState(() {
      addedItem.removeAt(index);
      saveItems(); // Save the updated list of items
    });
  }

  // Load items from SharedPreferences
  Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemList = prefs.getStringList(itemsKey);

    if (itemList != null) {
      setState(() {
        addedItem.clear();
        addedItem.addAll(itemList.map((itemString) {
          // Convert the JSON string back to a DataModel object
          return DataModel.fromJson(json.decode(itemString));
        }));
      });
    }
  }

  // Save items to SharedPreferences
  Future<void> saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemList = addedItem.map((item) {
      // Convert each DataModel object to a JSON string
      return json.encode(item.toJson());
    }).toList();

    await prefs.setStringList(itemsKey, itemList);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('Try to add Some Item'),
    );
    if (addedItem.isNotEmpty) {
      content = ItemListView(
        addedItem: addedItem,
        onRemoveItem: removeItem,
        onEditItem: editItem,
        onTapItem: (index) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) =>
                  DetailScreen(
                    item: addedItem[index],
                  ),
            ),
          );
        },

      );
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Memory Book'),

          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => AddScreen(onAdd: addItem),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        drawer: const DrawerWidget(),
        body: content);
  }
}

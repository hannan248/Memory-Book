import 'package:flutter/material.dart';
import 'package:memory_book/models/data_models.dart';

class ItemListView extends StatelessWidget {
  final List<DataModel> addedItem;
  final Function(int) onRemoveItem;
  final Function(int) onEditItem;
  final Function(int) onTapItem;

  const ItemListView({
    super.key,
    required this.addedItem,
    required this.onRemoveItem,
    required this.onEditItem,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addedItem.length,
      itemBuilder: (ctx, index) {
        final item = addedItem[index];
        return Dismissible(
          key: Key(item.id),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            onRemoveItem(index);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                onTapItem(index);
              },
              child: ExpansionTile(
                backgroundColor: Colors.blueGrey,
                leading: ClipOval(
                  child: Image.file(
                    item.image,
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  (addedItem[index].title).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                children: [
                  ListTile(
                    title: Text(
                      'Description: ${addedItem[index].description}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () => onEditItem(index),
                      icon: const Icon(Icons.edit),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

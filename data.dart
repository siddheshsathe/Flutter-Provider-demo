import 'package:flutter/material.dart';

class Items with ChangeNotifier {
  List<Item> _itemList = [];
  List<Item> get itemList => _itemList;

  void addItem(String name, String id, int price) {
    _itemList.add(Item(name: name, id: id, price: price));
    notifyListeners();
  }
}

class Item {
  final String name;
  final String id;
  final int price;

  Item({
    required this.name,
    required this.id,
    required this.price,
  });
}

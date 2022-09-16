import 'dart:convert';

import 'package:flutter/material.dart';

class RaffleItem extends ChangeNotifier {
  int? id;
  bool pay;
  bool selected;
  String name;

  RaffleItem(
      {this.id, required this.pay, required this.selected, required this.name});

  factory RaffleItem.fromMap(Map<String, dynamic> data) => RaffleItem(
      id: data['id'],
      pay: data['pay'] == 1,
      selected: data['selected'] == 1,
      name: data['name']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'pay': pay ? 1 : 0,
        'selected': selected ? 1 : 0,
        'name': name,
      };

  factory RaffleItem.fromJson(String data) {
    return RaffleItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}

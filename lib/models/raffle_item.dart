import 'dart:convert';

import 'package:flutter/material.dart';

class RaffleItem extends ChangeNotifier {
  final bool pay;
  final bool selected;
  final String name;

  RaffleItem({required this.pay, required this.selected, required this.name});

  factory RaffleItem.fromMap(Map<String, dynamic> data) => RaffleItem(
      pay: data['pay'], selected: data['selected'], name: data['name']);

  Map<String, dynamic> toMap() => {
        'pay': pay,
        'selected': selected,
        'name': name,
      };

  factory RaffleItem.fromJson(String data) {
    return RaffleItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}

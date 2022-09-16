import 'package:flutter/material.dart';
import 'package:rifa/models/raffle_item.dart';

import 'db_provider.dart';

class RafflesProvider with ChangeNotifier {
  final DbProvider _db = DbProvider.db;

  List<RaffleItem> _raffleItems = [];

  List<RaffleItem> get raffleItems => _raffleItems;

  late RaffleItem raffleItem;

  void getRaffleItems() async {
    await _db.getRaffleItems().then((value) {
      _raffleItems = value;
    });
    notifyListeners();
  }

  void getRaffleItem(int id) async {
    await _db.getRaffleItem(id).then((value) {
      raffleItem = value;
    });
    notifyListeners();
  }

  void updateRaffleItem(RaffleItem itemToUpdate, int position) async {
    await _db.updateRaffle(itemToUpdate);
    getRaffleItems();
    getRaffleItem(position);
  }

  void initBd() async {
    _db.getRaffleItems().then((value) => value.length != 100
        ? {
            for (int i = 0; i < 100; i++)
              {
                _db.insertRaffleItem(
                    RaffleItem(id: i, pay: false, selected: false, name: ''))
              },
            getRaffleItems()
          }
        : getRaffleItems());
  }
}

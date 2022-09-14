import 'package:flutter/material.dart';
import 'package:rifa/models/raffle_item.dart';

import 'package:rifa/widgets/widgets.dart';

class CustomRuffleList extends StatelessWidget {
  CustomRuffleList({super.key});

  final List<RaffleItem> _raffleItems = RaffleItem.createList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) => CustomRaffleCard(
        position: i,
        raffleItem: _raffleItems[i],
      ),
      itemCount: 100,
    );
  }
}

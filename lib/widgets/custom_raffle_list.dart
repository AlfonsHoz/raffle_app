import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rifa/models/raffle_item.dart';
import 'package:rifa/models/raffles_provider.dart';

import 'package:rifa/widgets/widgets.dart';

class CustomRuffleList extends StatelessWidget {
  CustomRuffleList({super.key});

  List<RaffleItem> _raffleItems = [];

  @override
  Widget build(BuildContext context) {
    final rafflesProvider = context.read<RafflesProvider>();
    rafflesProvider.getRaffleItems();
    _raffleItems = context.watch<RafflesProvider>().raffleItems;

    return _raffleItems.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, i) => CustomRaffleCard(
              _raffleItems[i],
              position: i,
            ),
            itemCount: 100,
          )
        : Container();
  }
}

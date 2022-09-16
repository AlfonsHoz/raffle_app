import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rifa/models/raffle_item.dart';

import '../models/raffles_provider.dart';

class CustomRaffleCard extends StatelessWidget {
  CustomRaffleCard(this.raffleItem, {super.key, required this.position});

  final int position;

  RaffleItem raffleItem;

  @override
  Widget build(BuildContext context) {
    final rafflesProvider = context.read<RafflesProvider>();

    return Card(
      color: _setCardColor(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(child: Text("$position")),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                  child:
                      Text(raffleItem.name.isNotEmpty ? raffleItem.name : '')),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _showNameDialog(context, rafflesProvider),
                    icon: const Icon(Icons.edit_rounded),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(20, 20),
                      ),
                      onPressed: () {
                        !raffleItem.selected
                            ? null
                            : {
                                raffleItem.pay = true,
                                rafflesProvider.updateRaffleItem(
                                    raffleItem, position)
                              };
                      },
                      child: const Text(
                        "Ok",
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(20, 20),
                      ),
                      onPressed: () {
                        !raffleItem.selected
                            ? null
                            : {
                                raffleItem.pay = false,
                                raffleItem.selected = false,
                                raffleItem.name = '',
                                rafflesProvider.updateRaffleItem(
                                    raffleItem, position)
                              };
                      },
                      child: const Text(
                        "X",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _setCardColor() {
    return raffleItem.pay && raffleItem.selected
        ? Colors.lightGreen.shade300
        : !raffleItem.pay && raffleItem.selected
            ? Colors.red.shade400
            : Colors.pink.shade200;
  }

  void _showNameDialog(BuildContext context, RafflesProvider rafflesProvider) {
    String auxName = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 5,
        title: const Text("Ingrese el nombre"),
        content: TextField(
          onChanged: (value) => auxName = value,
        ),
        actions: [
          TextButton(
              onPressed: () {
                auxName.isEmpty
                    ? null
                    : {
                        raffleItem.name = auxName,
                        raffleItem.selected = true,
                        rafflesProvider.updateRaffleItem(raffleItem, position),
                        rafflesProvider.getRaffleItem(position),
                        Navigator.pop(context),
                      };
              },
              child: const Text("Ok"))
        ],
      ),
    );
  }
}

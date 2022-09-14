import 'package:flutter/material.dart';
import 'package:rifa/models/raffle_item.dart';

class CustomRaffleCard extends StatefulWidget {
  const CustomRaffleCard(
      {super.key, required this.position, required this.raffleItem});

  final int position;

  final RaffleItem raffleItem;

  @override
  State<CustomRaffleCard> createState() => _CustomRaffleCardState();
}

class _CustomRaffleCardState extends State<CustomRaffleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: _setCardColor(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(child: Text("${widget.position}")),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                  child: Text(widget.raffleItem.name.isNotEmpty
                      ? widget.raffleItem.name
                      : '')),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _showNameDialog(context),
                    icon: const Icon(Icons.edit_rounded),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(20, 20),
                      ),
                      onPressed: () {
                        !widget.raffleItem.selected
                            ? null
                            : {widget.raffleItem.pay = true, setState(() {})};
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
                        !widget.raffleItem.selected
                            ? null
                            : {
                                widget.raffleItem.pay = false,
                                widget.raffleItem.selected = false,
                                widget.raffleItem.name = '',
                                setState(() {})
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
    return widget.raffleItem.pay && widget.raffleItem.selected
        ? Colors.lightGreen.shade300
        : !widget.raffleItem.pay && widget.raffleItem.selected
            ? Colors.red.shade400
            : Colors.orange.shade400;
  }

  void _showNameDialog(BuildContext context) {
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
                        widget.raffleItem.name = auxName,
                        widget.raffleItem.selected = true,
                        Navigator.pop(context),
                        setState(() {})
                      };
              },
              child: const Text("Ok"))
        ],
      ),
    );
  }
}

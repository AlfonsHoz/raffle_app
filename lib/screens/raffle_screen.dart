import 'package:flutter/material.dart';

import '../widgets/custom_raffle_list.dart';

class RaffleScreen extends StatelessWidget {
  const RaffleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: const Text("Rifa"),
      ),
      body: CustomRuffleList(),
    );
  }
}

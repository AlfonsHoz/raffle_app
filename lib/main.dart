import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rifa/models/raffles_provider.dart';
import 'package:rifa/screens/raffle_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [ListenableProvider(create: (_) => RafflesProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.read<RafflesProvider>().initBd();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const RaffleScreen(),
    );
  }
}

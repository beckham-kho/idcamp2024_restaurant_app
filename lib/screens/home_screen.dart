import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Ini Halaman Home',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Anjay"),
            style: ButtonStyle(
              iconColor: WidgetStatePropertyAll(Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
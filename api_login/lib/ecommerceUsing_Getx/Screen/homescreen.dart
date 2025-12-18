import 'package:flutter/material.dart';

class HomePageGetx extends StatefulWidget {
  const HomePageGetx({super.key});

  @override
  State<HomePageGetx> createState() => _HomePageGetxState();
}

class _HomePageGetxState extends State<HomePageGetx> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: Column(children: [],),
    );
  }
}

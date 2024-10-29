import 'package:flutter/material.dart';
import 'list_item.dart';
import 'makanan.dart';
import 'styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Makanan> listMenu = Makanan.dummyData;

    return SafeArea(
        child: Column(children: [
      const SizedBox(
        height: 10,
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.list_alt_sharp, size: 30),
          SizedBox(width: 10),
          Text('List Kuliner', style: textHeader1),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Expanded(
          child: ListView.builder(
        itemCount: listMenu.length,
        itemBuilder: (context, index) {
          return ListItem(makanan: listMenu[index]);
        },
      ))
    ]));
  }
}



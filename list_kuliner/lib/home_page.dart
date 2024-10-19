import 'package:flutter/material.dart';
import 'list_item.dart';
import 'makanan.dart';
import 'styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.list_alt_sharp, size: 30),
            SizedBox(width: 10),
            Text('List Kuliner', style: textHeader1),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: listMakanan.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return ListItem(makanan: listMakanan[index]);
            },
          ),
        ),
      ],
    );
  }
}

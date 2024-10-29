import 'package:flutter/material.dart';
import 'package:list_kuliner/detail_page.dart';
import 'makanan.dart';
import 'styles.dart';

class ListItem extends StatelessWidget {
  final Makanan makanan;

  const ListItem({super.key, required this.makanan});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      makanan: makanan,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 100,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              const BoxShadow(
                  color: headerBackColor, offset: Offset(1, 2), blurRadius: 6)
            ]),
        child: Row(
          children: [
            gambar(),
            const SizedBox(width: 10),
            deskripsiText(),
            const Icon(Icons.food_bank_rounded, color: iconColor)
          ],
        ),
      ),
    );
  }

  ClipRRect gambar() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Image.asset(
        makanan.gambar,
        height: 75,
        width: 85,
        fit: BoxFit.cover,
      ),
    );
  }

  Expanded deskripsiText() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(makanan.nama, style: textHeader1),
          Text(
            makanan.deskripsi,
            style: const TextStyle(color: Colors.black38),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 10),
          Text(
            makanan.harga,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

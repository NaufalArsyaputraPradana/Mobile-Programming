import 'package:flutter/material.dart';
import 'makanan.dart';
import 'detail_page.dart';

class ListItem extends StatelessWidget {
  final Makanan makanan;

  const ListItem({super.key, required this.makanan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              gambar: makanan.gambar,
              nama: makanan.nama,
              detail: makanan.detail,
              waktubuka: makanan.waktubuka,
              kalori: makanan.kalori,
              harga: makanan.harga,
              gambarlain: makanan.gambarlain,
              bahan: makanan.bahan,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 178, 178, 178),
              offset: const Offset(1.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              makanan.gambar,
              height: 75,
              width: 75,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  makanan.nama,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  makanan.deskripsi,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

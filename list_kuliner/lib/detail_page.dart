import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String gambar;
  final String nama;
  final String detail;
  final String waktubuka;
  final String kalori;
  final String harga;
  final List<String> gambarlain;
  final List<Map<String, String>> bahan;

  const DetailPage({
    Key? key,
    required this.gambar,
    required this.nama,
    required this.detail,
    required this.waktubuka,
    required this.kalori,
    required this.harga,
    required this.gambarlain,
    required this.bahan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(gambar),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(
                nama,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      const Icon(Icons.access_time_filled,
                          color: Color.fromARGB(255, 255, 230, 0)),
                      const SizedBox(height: 8),
                      Text(waktubuka),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 8),
                      Text(kalori),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.green),
                      const SizedBox(height: 8),
                      Text(harga),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                detail,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: gambarlain.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(url, scale: 0.5),
                  );
                }).toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Bahan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: bahan.map((item) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(item.keys.first, width: 40, height: 40),
                      const SizedBox(width: 10),
                      Text(item.values.first),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

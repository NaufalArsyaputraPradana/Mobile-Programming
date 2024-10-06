import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(RestaurantProfileApp());
}

class RestaurantProfileApp extends StatelessWidget {
  final Map<String, String> restaurantData = {};

  RestaurantProfileApp({super.key}) {
    restaurantData['name'] = 'Rm. Sedap Rasa';
    restaurantData['email'] = 'info@sedaprasa.com';
    restaurantData['phone'] = '+6281234567890';
    restaurantData['image'] = 'resto.jpeg';
    restaurantData['description'] =
        'Restoran ini terkenal dengan hidangan khas nusantara yang lezat dan bahan-bahan berkualitas.';
    restaurantData['address'] =
        'Jalan Imam Bonjol No. 207, Semarang, Jawa Tengah';
    restaurantData['menu'] = 'Ayam Goreng, Nasi Goreng, Sate Ayam';
    restaurantData['hours'] = 'Senin - Minggu: 10:00 - 22:00';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profil Restoran",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Profil Restoran"),
          backgroundColor: Colors.orangeAccent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Header dengan nama restoran
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(
                  restaurantData['name'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),

              // Gambar profil restoran dengan border radius dan shadow
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: AssetImage('assets/${restaurantData["image"] ?? ''}'),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Baris ikon untuk kontak (email, telepon, map)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCircleIcon(Icons.email, Colors.green[900]!,
                      "mailto:${restaurantData['email'] ?? ''}?subject=Tanya%20Seputar%20Resto"),
                  buildCircleIcon(
                    Icons.map,
                    Colors.blueAccent,
                    "https://maps.app.goo.gl/L1wJo4V1V3d2uniZ6",
                  ),
                  buildCircleIcon(
                    Icons.phone,
                    Colors.deepPurple,
                    "https://wa.me/6282223199601${restaurantData['phone']}",
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Deskripsi restoran
              teksKotak(Colors.black54, 'Deskripsi', Icons.description),
              Text(
                restaurantData['description'] ?? '',
                style: const TextStyle(fontSize: 18, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Teks Menu
              teksKotak(Colors.orange, 'Menu', Icons.fastfood),
              const SizedBox(height: 10),

              // List Menu dengan bullet point dan padding
              listItemMenu(restaurantData['menu']?.split(', ') ?? []),
              const SizedBox(height: 20),

              // Alamat restoran dalam bentuk paragraf deskripsi
              teksKotak(Colors.black54, 'Alamat', Icons.location_pin),
              Text(
                restaurantData['address'] ?? '',
                style: const TextStyle(fontSize: 18, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Jam Pelayanan dalam bentuk paragraf deskripsi
              teksKotak(Colors.black54, 'Jam Pelayanan', Icons.access_time),
              Text(
                restaurantData['hours'] ?? '',
                style: const TextStyle(fontSize: 18, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk membuat kotak dengan teks dan ikon (misalnya deskripsi, alamat, menu)
  Container teksKotak(Color bgColor, String teks, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            teks,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Widget tombol kontak dengan ikon berbentuk lingkaran
  Widget buildCircleIcon(IconData icon, Color color, String uri) {
    return GestureDetector(
      onTap: () {
        launchUri(uri);
      },
      child: CircleAvatar(
        radius: 30,
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  // Fungsi untuk membuka URL (email, telepon, peta)
  Future<void> launchUri(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Tidak dapat membuka: $uri');
    }
  }

  // Fungsi untuk menampilkan list item menu
  Widget listItemMenu(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              const Icon(Icons.check, color: Colors.orange),
              const SizedBox(width: 10),
              Text(
                item,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

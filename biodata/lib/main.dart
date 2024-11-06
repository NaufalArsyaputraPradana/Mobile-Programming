import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

Future<void> launch(String uri) async {
  if (!await launchUrl(Uri.parse(uri))) {
    throw Exception('Tidak dapat memanggil: $uri');
  }
}

class MainApp extends StatelessWidget {
  final biodata = <String, String>{};

  MainApp({super.key}) {
    biodata['name'] = 'Barbatos (Venti)';
    biodata['email'] = 'venti@genshinimpact.com';
    biodata['phone'] = '+62345678910';
    biodata['image'] = 'Venti_Card.png';
    biodata['hobby'] = 'Bermain Lira dan Flute';
    biodata['addr'] = 'St. Freeway in side of Moonstad';
    biodata['desc'] =
        "'A bard that seems to have arrived on some unknown wind — sometimes sings songs as old as the hills, and other times sings poems fresh and new. Likes apples and lively places but is not a fan of cheese or anything sticky. When using his Anemo power to control the wind, it often appears as feathers, as he's fond of that which appears light and breezy.'";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aplikasi Biodata",
      home: Scaffold(
        appBar: AppBar(title: const Text("Aplikasi Biodata")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  btnContact(Icons.alternate_email, Colors.green[900]!,
                      "mailto:${biodata['email'] ?? ''}"),
                  btnContact(Icons.mark_email_read, Colors.blueAccent,
                      "https://wa.me/${biodata['phone']}"),
                  btnContact(
                      Icons.phone, Colors.deepPurple, "tel:${biodata['phone']}")
                ],
              ),
              teksKotak(Colors.black, biodata['name'] ?? ''),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black),
                child: Column(
                  children: [
                    Text(
                      biodata['name'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      biodata['desc'] ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Image.asset('assets/${biodata["image"] ?? ''}'),
              const SizedBox(height: 10),
              teksKotak(Colors.black38, 'Deskripsi'),
              const SizedBox(height: 10),
              textAttribute('Hobby', biodata['hobby'] ?? ''),
              textAttribute('Alamat', biodata['addr'] ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget teksKotak(Color bgColor, String teks) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(color: bgColor),
      child: Text(
        teks,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget textAttribute(String judul, String teks) {
    return Row(
      children: [
        Container(
          width: 80,
          child: Text(
            '- $judul ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const Text(
          ': ',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          teks,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget btnContact(IconData icon, Color color, String uri) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          launch(uri);
        },
        child: Icon(icon),
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: color,
            foregroundColor: Colors.white),
      ),
    );
  }
}

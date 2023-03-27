import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

Client client = Client();
Avatars avatars = Avatars(client);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  client
          .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
          .setProject('63dd59dd745a2c91cada') // Your project ID
      ;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: FutureBuilder(
          future: avatars.getCreditCard(
            code: 'diner',
          ), //works for both public file and private file, for private files you need to be logged in
          builder: (context, snapshot) {
            return snapshot.hasData && snapshot.data != null
                ? Image.memory(
                    snapshot.data!,
                  )
                : const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

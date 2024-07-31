import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Url Uygulaması"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                urlLauncherMethod('https://www.youtube.com/');
              },
              child: const Text("Go Youtube"),
            ),
            ElevatedButton(
              onPressed: () {
                urlLauncherMethod('sms:+90 1234');
              },
              child: const Text("Send SMS"),
            ),
            ElevatedButton(
              onPressed: () {
                urlLauncherMethod('tel:+90 1234');
              },
              child: const Text("Call"),
            ),
            ElevatedButton(
              onPressed: () {
                urlLauncherMethod('mailto:gorkem@gmail.com?subject=News&body=New%20plugin');
              },
              child: const Text("Send Mail"),
            ),
          ],
        ),
      ),
    );
  }

  void urlLauncherMethod(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      if (url.startsWith('sms:') || url.startsWith('tel:') || url.startsWith('mailto:')) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } else {
      if (url.startsWith('mailto:')) {
        _showEmailAppDialog();
      } else {
        print('Bu URL açılamıyor: $url');
      }
    }
  }

  void _showEmailAppDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('E-posta Uygulaması Bulunamadı'),
          content: Text('Cihazınızda e-posta uygulaması bulunamadı. Lütfen bir e-posta uygulaması yükleyin veya ayarlarınızı kontrol edin.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}

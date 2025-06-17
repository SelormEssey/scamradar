import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/report_form.dart';
import 'services/firebase_service.dart';
import 'screens/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScamRadar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/search': (_) => SearchScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  void openReportForm(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ReportForm()),
    );

    if (result != null && result is Map) {
      await uploadReport(
        phone: result['phone'],
        username: result['username'],
        scamType: result['scamType'],
        description: result['description'],
        image: result['image'],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Scam report submitted!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ScamRadar')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => openReportForm(context),
              child: Text('Report a Scam'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/search'),
              child: Text('Search a Scammer'),
            ),
          ],
        ),
      ),
    );
  }
}

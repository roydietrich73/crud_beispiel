import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Operations Beispiel',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = "Initialer Datenwert";

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saved_data', data);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Daten gespeichert!'),
    ));
  }

  _readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      data = prefs.getString('saved_data') ?? "Keine Daten vorhanden";
    });
  }

  _updateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saved_data', 'Aktualisierter Datenwert');
    _readData();
  }

  _deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('saved_data');
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Operations Beispiel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _saveData();
              },
              child: const Text('Speichern'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _readData();
              },
              child: const Text('Lesen'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _updateData();
              },
              child: const Text('Aktualisieren'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _deleteData();
              },
              child: const Text('Löschen'),
            ),
            const SizedBox(height: 16.0),
            Text('Aktuelle Daten: $data'),
          ],
        ),
      ),
    );
  }
}
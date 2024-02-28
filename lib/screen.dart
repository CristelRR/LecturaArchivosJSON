import 'dart:convert';
import 'package:flutter/material.dart';
import 'Item.dart';

class JsonListViewScreen extends StatefulWidget {
  const JsonListViewScreen({Key? key})
      : super(key: key); // Agregar parámetro key y const

  @override
  _JsonListViewScreenState createState() => _JsonListViewScreenState();
}

class _JsonListViewScreenState extends State<JsonListViewScreen> {
  late List<Item> items;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    try {
      String jsonString =
          await DefaultAssetBundle.of(context).loadString('assets/data.json');
      List<dynamic> jsonList = json.decode(jsonString);

      setState(() {
        items = jsonList.map((item) => Item.fromJson(item)).toList();
      });
    } catch (e) {
      print('Error cargando el archivo JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          // Centra el título
          child: Text(
            'Uso de archivos JSON',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: items != null
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.orange[50],
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      items[index].name,
                      style: TextStyle(color: Colors.orange[900]),
                    ),
                    subtitle: Text(
                      'ID: ${items[index].id}',
                      style: TextStyle(color: Colors.orange[700]),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
    );
  }
}

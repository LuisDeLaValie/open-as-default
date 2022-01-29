import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_as_default/open_as_default.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? _file;
  @override
  void initState() {
    super.initState();
    OpenAsDefault.getFileIntent.then((value) {
      if (value != null) {
        setState(() {
          _file = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: (_file == null) ? PaginaUno() : PaginaDos(path: _file!.path),
    );
  }
}

class PaginaUno extends StatelessWidget {
  const PaginaUno({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Uno'),
      ),
      body: const Center(
        child: Text('Pagina Uno'),
      ),
    );
  }
}

class PaginaDos extends StatelessWidget {
  final String path;
  const PaginaDos({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Dos'),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          const Text('Pagina Dos'),
          Text(path),
        ],
      ),
    );
  }
}

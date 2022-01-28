import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
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
        title: Text('Pagina Uno'),
      ),
      body: Center(
        child: Container(
          child: Text('Pagina Uno'),
        ),
      ),
    );
  }
}

class PaginaDos extends StatefulWidget {
  final String path;
  const PaginaDos({Key? key, required this.path}) : super(key: key);

  @override
  State<PaginaDos> createState() => _PaginaDosState();
}

class _PaginaDosState extends State<PaginaDos> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaderPortada();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina Dos'),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          const Text('Pagina Dos'),
          (lista == null)
              ? Container()
              : Container(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.memory(
                        lista!,
                        fit: BoxFit.fill,
                      )),
                )
        ],
      ),
    );
  }

  Uint8List? lista;

  loaderPortada() async {
    final document = await PdfDocument.openFile(widget.path);
    final page = await document.getPage(1);
    final image = await page.render(width: page.width, height: page.height);
    await page.close();

    setState(() {
      lista = image!.bytes;
    });
  }
}

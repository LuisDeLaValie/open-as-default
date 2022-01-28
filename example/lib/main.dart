import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:open_as_default/open_as_default.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _path = 'Unknown';
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String path;
    File? file;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      file = await OpenAsDefault.getFileIntent;
      path = file?.path ?? 'Unknown File';
      loaderPortada(file?.path ?? "");
    } on PlatformException {
      path = 'Failed to get FIle.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _path = path;
    });
  }

  Uint8List? _lista;
  // utilizanod el paque uri_to_file para comvertir el URI en un file
  // tambien en esta ocacion usaremos el paquete native_pdf_renderer para mostar el pdf
  loaderPortada(String path) async {
    final document = await PdfDocument.openFile(path);
    final page = await document.getPage(1);
    final image = await page.render(width: page.width, height: page.height);
    await page.close();

    setState(() {
      _lista = image!.bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(_path),
              if (_lista != null)
                Container(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.memory(
                        _lista!,
                        fit: BoxFit.fill,
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }
}

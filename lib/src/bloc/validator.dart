import 'dart:async';

import 'package:almacen/src/models/artModel.dart';

class Validators {
  final validarHttp =
      StreamTransformer<List<ArtModel>, List<ArtModel>>.fromHandlers(
          handleData: (art, sink) {
    final geoArt = art.where((s) => s.hola == 'http').toList();
    sink.add(geoArt);
  });
}

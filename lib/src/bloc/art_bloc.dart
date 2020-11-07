import 'dart:async';

import 'package:almacen/src/bloc/validator.dart';
import 'package:almacen/src/models/artModel.dart';
import 'package:almacen/src/providers/dbProvider.dart';

class ArtBloc with Validators {
  static final ArtBloc _singleton = new ArtBloc._internal();

  factory ArtBloc() {
    return _singleton;
  }

  ArtBloc._internal() {
    obtenerArt();
  }

  final _artController = StreamController<List<ArtModel>>.broadcast();

  Stream<List<ArtModel>> get artStreamHttp =>
      _artController.stream.transform(validarHttp);

  dispose() {
    _artController?.close();
  }

  obtenerArt() async {
    _artController.sink.add(await DBProvider.db.getTodosArt());
  }

  agregarArt(ArtModel art) async {
    await DBProvider.db.nuevoArt(art);
    obtenerArt();
  }

  editarArt(ArtModel art) async {
    await DBProvider.db.updateArt(art);
    obtenerArt();
  }

  borrarArt(int id) async {
    await DBProvider.db.deleteArt(id);
    obtenerArt();
  }

  borrarArtTODOS() async {
    await DBProvider.db.deleteAll();
    obtenerArt();
  }
}

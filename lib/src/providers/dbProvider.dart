import 'dart:io';

import 'package:almacen/src/models/artModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ArtDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Inventario ('
          ' id INTEGER PRIMARY KEY,'
          ' nombreArticulo TEXT,'
          ' caracteristica TEXT,'
          ' cantidad TEXT,'
          ' marca TEXT'
          ')');
    });
  }

  // CREAR Registros
  nuevoArtRaw(ArtModel nuevoArt) async {
    final db = await database;

    final res = await db.rawInsert(
        "INSERT Into Inventario (id, nombreArticulo, caracteristica, cantidad, marca) "
        "VALUES ( ${nuevoArt.id}, '${nuevoArt.nombreArticulo}', '${nuevoArt.caracteristica}', '${nuevoArt.cantidad}', '${nuevoArt.marca}' )");
    return res;
  }

  nuevoArt(ArtModel nuevoArt) async {
    final db = await database;

    final res = db.insert('Inventario', nuevoArt.toJson());

    return res;
  }

  // SELECT - Obtener información
  Future<ArtModel> getArtId(int id) async {
    final db = await database;
    final res = await db.query('Inventario', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ArtModel.fromJson(res.first) : null;
  }

  Future<List<ArtModel>> getTodosArt() async {
    final db = await database;
    final res = await db.query('Inventario');

    List<ArtModel> list =
        res.isNotEmpty ? res.map((c) => ArtModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<ArtModel>> getArtPorMarca(String marca) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM Inventario WHERE marca='$marca'");

    List<ArtModel> list =
        res.isNotEmpty ? res.map((c) => ArtModel.fromJson(c)).toList() : [];
    return list;
  }

  // Actualizar Registros
  Future<int> updateArt(ArtModel nuevoArt) async {
    final db = await database;
    final res = await db.update('Inventario', nuevoArt.toJson(),
        where: 'id = ?', whereArgs: [nuevoArt.id]);
    return res;
  }

  // Eliminar registros
  Future<int> deleteArt(int id) async {
    final db = await database;
    final res = await db.delete('Inventario', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Inventario');
    return res;
  }
}

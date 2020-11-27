import 'package:flutter/material.dart';

import 'package:almacen/src/models/artModel.dart';
import 'package:almacen/src/bloc/art_bloc.dart';

class ListadoPage extends StatelessWidget {
  final artBloc = new ArtBloc();

  @override
  Widget build(BuildContext context) {
    artBloc.obtenerArt();

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Articulos')),
      body: _crearListado(),
    );
  }

  Widget _crearListado() {
    return StreamBuilder<List<ArtModel>>(
      stream: artBloc.artStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ArtModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final art = snapshot.data;

        if (art.length == 0) {
          return Center(
            child: Text('No hay información'),
          );
        }

        return ListView.builder(
            itemCount: art.length,
            itemBuilder: (context, i) => Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                onDismissed: (direction) => artBloc.borrarArt(art[i].id),
                child: ListTile(
                    leading: Icon(Icons.cloud_queue,
                        color: Theme.of(context).primaryColor),
                    title: Text(art[i].nombreArticulo),
                    subtitle: Text('ID: ${art[i].id}'),
                    trailing:
                        Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                    onTap: () {
                      Navigator.pushNamed(context, 'actualizar',
                          arguments: art[i]);
                    })));
      },
    );
  }
}

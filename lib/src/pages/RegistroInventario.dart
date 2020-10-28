import 'package:almacen/src/bloc/art_bloc.dart';
import 'package:flutter/material.dart';
import 'package:almacen/src/models/artModel.dart';
// import 'package:almacen/src/utils/utils.dart' as utils;

class RegistroProducto extends StatefulWidget {
  RegistroProducto({Key key}) : super(key: key);

  @override
  _RegistroProductoState createState() => _RegistroProductoState();
}

class _RegistroProductoState extends State<RegistroProducto> {
  final formKey = GlobalKey<FormState>();

  final nomArtController = TextEditingController();
  final caracController = TextEditingController();
  final cantController = TextEditingController();
  final marcaController = TextEditingController();

  ArtModel artModel;

  final artBloc = new ArtBloc();

  ArtModel articulo = new ArtModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 30),
              _crearNombre(),
              SizedBox(height: 15),
              _crearCaracteristica(),
              SizedBox(height: 15),
              _crearCantidad(),
              SizedBox(height: 15),
              _crearMarca(),
              SizedBox(height: 30),
              _crearBoton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      // !Vinculando el producto al modelo
      // initialValue: articulo.nombreArticulo,
      decoration: InputDecoration(
        labelText: 'Nombre del Producto',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Tiene que colocar información";
        }
        return null;
      },
      controller: nomArtController,
    );
  }

  Widget _crearCaracteristica() {
    return TextFormField(
      // !Vinculando el producto al modelo
      // initialValue: articulo.caracteristica,
      decoration: InputDecoration(
        labelText: 'Caracteristica',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Tiene que colocar información";
        }
        return null;
      },
      controller: caracController,
    );
  }

  Widget _crearCantidad() {
    return TextFormField(
      // !Vinculando el producto al modelo
      // initialValue: articulo.cantidad,
      decoration: InputDecoration(
        labelText: 'Cantidad',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Tiene que colocar información";
        }
        return null;
      },
      controller: cantController,
    );
  }

  Widget _crearMarca() {
    return TextFormField(
      // !Vinculando el producto al modelo
      // initialValue: articulo.marca,
      decoration: InputDecoration(
        labelText: 'Marca',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Tiene que colocar información";
        }
        return null;
      },
      controller: marcaController,
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: () {
        if (formKey.currentState.validate()) {
          print("Guardar" + nomArtController.text);
          artBloc.agregarArt(ArtModel(
              nombreArticulo: nomArtController.text,
              caracteristica: caracController.text,
              cantidad: cantController.text,
              marca: marcaController.text));
        }
      },
    );
  }
}

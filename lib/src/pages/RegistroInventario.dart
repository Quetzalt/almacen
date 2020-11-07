import 'package:almacen/src/bloc/art_bloc.dart';
import 'package:flutter/material.dart';
import 'package:almacen/src/models/artModel.dart';

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

  _RegistroProductoState();

  @override
  Widget build(BuildContext context) {
    final ArtModel art = ModalRoute.of(context).settings.arguments;
    _init(art);

    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
      ),
      body: Container(
        color: Colors.white,
        child: _crearForm(art),
      ),
    );
  }

  _init(ArtModel art) {
    nomArtController.text = art.nombreArticulo;
    caracController.text = art.caracteristica;
    cantController.text = art.cantidad;
    marcaController.text = art.marca;
  }

  Widget _crearForm(ArtModel art) {
    return Form(
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
          _crearBoton(art)
        ],
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

  Widget _crearBoton(ArtModel art) {
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
          if (art.id > 0) {
            // Actualización
            art.nombreArticulo = nomArtController.text;
            art.caracteristica = caracController.text;
            art.cantidad = cantController.text;
            art.marca = marcaController.text;

            artBloc.editarArt(art);
          } else {
            // Registro
            artBloc.agregarArt(ArtModel(
                nombreArticulo: nomArtController.text,
                caracteristica: caracController.text,
                cantidad: cantController.text,
                marca: marcaController.text));
          }
        }
      },
    );
  }
}

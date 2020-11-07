class ArtModel {
  ArtModel({
    this.id,
    this.nombreArticulo = '',
    this.caracteristica = '',
    this.cantidad = '',
    this.marca = '',
  }) {
    if (this.id != null) {
      this.hola = 'http';
    }
  }

  int id;
  String nombreArticulo;
  String caracteristica;
  String cantidad;
  String marca;
  String hola;

  ArtModel.empty();

  factory ArtModel.fromJson(Map<String, dynamic> json) => ArtModel(
        id: json["id"],
        nombreArticulo: json["nombreArticulo"],
        caracteristica: json["caracteristica"],
        cantidad: json["cantidad"],
        marca: json["marca"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreArticulo": nombreArticulo,
        "caracteristica": caracteristica,
        "cantidad": cantidad,
        "marca": marca,
      };
}

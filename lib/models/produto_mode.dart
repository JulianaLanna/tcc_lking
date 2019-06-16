class Produto{
  int id;
  String name;
  String quantidade;
  String valor;

  Produto ({this.id, this.name, this.quantidade, this.valor});

  //To insert the data in the bd, we need to convert it into a Map
  //Para insertar los datos en la bd, necesitamos convertirlo en un Map
  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "quantidade": quantidade,
    "valor": valor
  };

  //to receive the data we need to pass it from Map to json
  //para recibir los datos necesitamos pasarlo de Map a json
  factory Produto.fromMap(Map<String, dynamic> json) => new Produto(
    id: json["id"],
    name: json["name"],
    quantidade: json["quantidade"],
    valor: json["valor"],
  );
}
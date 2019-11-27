class Produto{
  int id;
  String descricao;
  String prioridade;
  String setor;
  String proprietario;
  String local;

  Produto ({this.id, this.descricao, this.prioridade, this.setor, this.proprietario, this.local});

  //To insert the data in the bd, we need to convert it into a Map
  //Para insertar los datos en la bd, necesitamos convertirlo en un Map
  Map<String, dynamic> toMap() => {
    "id": id,
    "descricao": descricao,
    "prioridade": prioridade,
    "setor": setor,
    "proprietario": proprietario,
    "local": local
  };

  //to receive the data we need to pass it from Map to json
  //para recibir los datos necesitamos pasarlo de Map a json
  factory Produto.fromMap(Map<String, dynamic> json) => new Produto(
    id: json["id"],
    descricao: json["descricao"],
    prioridade: json["prioridade"],
    setor: json["setor"],
    proprietario: json["proprietario"],
    local: json["local"],
  );
}
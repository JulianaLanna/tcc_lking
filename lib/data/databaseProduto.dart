import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tcc_lking/models/produto_mode.dart';

class ProdutoDatabaseProvider{
  ProdutoDatabaseProvider._();

  static final  ProdutoDatabaseProvider db = ProdutoDatabaseProvider._();
  Database _database;

  //para evitar que abra varias conexciones una y otra vez podemos usar algo como esto..
  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await getDatabaseInstanace();
    return _database;
  }

  Future<Database> getDatabaseInstanace() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "chamado.db");
     return await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Produto ("
        "id integer primary key,"
        "descricao TEXT,"
        "prioridade TEXT,"
        "setor TEXT,"
        "proprietario TEXT,"
        "local TEXT"
        ")");
      });
  }

  //Query
  //Busca todos os produtos
  Future<List<Produto>> getAllProdutos() async {
    final db = await database;
    var response = await db.query("Produto");
    List<Produto> list = response.map((c) => Produto.fromMap(c)).toList();
    return list;
  }

  //Query
  //Busca por produtos pelo ID
  Future<Produto> getProdutoWithId(int id) async {
    final db = await database;
    var response = await db.query("Produto", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Produto.fromMap(response.first) : null;
  }

  //Insert
  addProdutoToDatabase(Produto produto) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Produto");
    int id = table.first["id"];
    produto.id = id;
    var raw = await db.insert(
      "Produto",
      produto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;    

  }

  //Delete
  //Delete produto with id
  deleteProdutoWithId(int id) async {
    final db = await database;
    return db.delete("Produto", where: "id = ?", whereArgs: [id]);
  } 

  //Delete all produto
  deleteAllProduto() async {
    final db = await database;
    db.delete("Produto");
  } 

  //Update
  updateProduto(Produto produto) async {
    final db = await database;
    var response = await db.update("Produto", produto.toMap(),
    where: "id = ?", whereArgs: [produto.id]);
    return response;
  }

}
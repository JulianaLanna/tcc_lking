import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => new _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  BuildContext _ctx;

  void _submitProduto() {
    Navigator.of(context).pushNamed("/Produto");
  }

  /**
   * 
   * Ajustar para fazer a chamada das outras pages
   * 
   * Adicionar no rooter la no arquivo: main.dart
   */
  void _submitFuncionario() {
    Navigator.of(context).pushNamed("/home");
  }
  void _submitLoja() {
    Navigator.of(context).pushNamed("/home");
  }
  void _submitVenda() {
    Navigator.of(context).pushNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var ProdutoBtn = new RaisedButton(
      onPressed: _submitProduto,
      child: new Text("Produto"),
      color: Colors.blue,
    );

    var FuncBtn = new RaisedButton(
      onPressed: _submitFuncionario,
      child: new Text("Funcionario"),
      color: Colors.blue,
    );

    var LojaBtn = new RaisedButton(
      onPressed: _submitLoja,
      child: new Text("Loja"),
      color: Colors.blue,
    );

    var VendaBtn = new RaisedButton(
      onPressed: _submitVenda,
      child: new Text("Venda"),
      color: Colors.blue,
    );



    var MenuPage = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Tcc Login",
          textScaleFactor: 2.0,
        ),
        ProdutoBtn,
        FuncBtn,
        LojaBtn,
        VendaBtn,
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Menu"),
      ),
      body: Container(
        child: Center(
          child: MenuPage,
        ),
      ),
    );
  }

}

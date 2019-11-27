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

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var ProdutoBtn = new RaisedButton(
      onPressed: _submitProduto,
      child: new Text("Chamado"),
      color: Colors.blue,
    );




    var MenuPage = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Abertura de Chamado",
          textScaleFactor: 2.0,
        ),
        ProdutoBtn,
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

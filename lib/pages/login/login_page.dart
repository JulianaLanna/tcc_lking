import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BuildContext _ctx;

  void _submitProduto() {
    Navigator.of(context).pushNamed("/Menu");
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var ProdutoBtn = new RaisedButton(
      onPressed: _submitProduto,
      child: new Text("Entrar"),
      color: Colors.blue, 
    );




    var LoginPage = new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Text(
          "Sinpro",
          textScaleFactor: 3.0,
        ),

        ProdutoBtn,
      ],
    );

    return new Scaffold(
      body: Container(
        child: Center(
          child: LoginPage,
        ),
      ),
    );
  }

  
}

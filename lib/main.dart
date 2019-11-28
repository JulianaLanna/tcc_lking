import 'package:flutter/material.dart';
import 'package:tcc_lking/pages/login/login_page.dart';
import 'package:tcc_lking/pages/menu/menu_page.dart';
import 'package:tcc_lking/pages/produto/produto_page.dart';

void main() => runApp(MyApp());

final routes = {
  '/Menu': (BuildContext context) => new MenuPage(),
  '/Produto': (BuildContext context) => new ProdutoPage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Crud',
      theme: new ThemeData(primarySwatch: Colors.blue),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

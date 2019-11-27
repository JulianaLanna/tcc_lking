import 'package:flutter/material.dart';
import 'package:tcc_lking/data/databaseProduto.dart';
import 'package:tcc_lking/models/produto_mode.dart';
import 'package:tcc_lking/pages/produto/produto_detail.dart';


class ProdutoPage extends StatefulWidget {
  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  @override
  void didUpdateWidget(ProdutoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Chamado"),
        actions: <Widget>[
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: (){
              ProdutoDatabaseProvider.db.deleteAllProduto();
              setState(() { 
              });
            },
            child: Text('Delete All',
              style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Colors.black
             )
            ),
          )
        ],
      ),
      body: 
      FutureBuilder<List<Produto>>(
        //we call the method, which is in the folder db file database.dart 
        future: ProdutoDatabaseProvider.db.getAllProdutos(),
        builder: (BuildContext context, AsyncSnapshot<List<Produto>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              //Count all records
              itemCount: snapshot.data.length,
              //all the records that are in the client table are passed to an item Client item = snapshot.data [index];
              itemBuilder: (BuildContext context, int index){
                Produto item = snapshot.data[index];
                //delete one register for id
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (diretion) {
                    ProdutoDatabaseProvider.db.deleteProdutoWithId(item.id);
                  },
                  //Now we paint the list with all the records, which will have a number, name, phone
                  child: ListTile(
                    title: Text(item.descricao),
                    subtitle: Text(item.proprietario),
                    leading: CircleAvatar(child: Text(item.id.toString())),
                    //If we press one of the cards, it takes us to the page to edit, with the data onTap:
                    //This method is in the file add_editclient.dart
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProdutoDetail(
                          true,
                          //Here is the record that we want to edit
                          produto: item,                          
                        )                        
                      )
                      );
                    },
                  ),
                );
              },
            );
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      //This button takes us to the method add new register, which is in the file add_editclient.dart
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProdutoDetail(false)));
        },
      ),
    );
  }
}

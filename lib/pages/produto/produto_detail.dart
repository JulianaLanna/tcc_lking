import 'package:flutter/material.dart';
import 'package:tcc_lking/data/databaseProduto.dart';
import 'package:tcc_lking/models/produto_mode.dart';

class ProdutoDetail extends StatefulWidget {
  final bool edit;
  final Produto produto;

  ProdutoDetail(this.edit, {this.produto})
  : assert(edit == true || produto ==null);


  @override
  _ProdutoDetailState createState() => _ProdutoDetailState();
}

class _ProdutoDetailState extends State<ProdutoDetail> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController quantidadeEditingController = TextEditingController();
  TextEditingController valorEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {    
    super.initState();
    //if you press the button to edit it must pass to true, 
    //instantiate the name and phone in its respective controller, (link them to each controller)
    if(widget.edit == true){
      nameEditingController.text = widget.produto.name;
      quantidadeEditingController.text = widget.produto.quantidade;
      valorEditingController.text = widget.produto.valor;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.edit?"Editar Produto":"Adiciona Produto"),),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(
                  size: 300,
                ),
                //if it is new record, it asks to enter data, : but it paints the data brought in the item
                textFormField(nameEditingController, "Name", "Enter Name",
                Icons.person, widget.edit ? widget.produto.name : "name"),
                textFormFieldPhone(quantidadeEditingController, "Quantidade", "Enter Quantidade", 
                Icons.person, widget.edit ? widget.produto.quantidade : "quantidade",),
                textFormFieldPhone(valorEditingController, "Valor", "Enter Valor", 
                Icons.person, widget.edit ? widget.produto.valor : "valor",),
                
                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text('Save',
                    style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.white
                  ),                  
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState.validate()){
                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data'))
                        );
                      }else if (widget.edit == true) {
                        ProdutoDatabaseProvider.db.updateProduto(new Produto(
                          name: nameEditingController.text,
                          quantidade: quantidadeEditingController.text,
                          valor: valorEditingController.text,
                          id: widget.produto.id ));
                          Navigator.pop(context);
                      } else {
                        await ProdutoDatabaseProvider.db.addProdutoToDatabase(new Produto(
                          name: nameEditingController.text,
                          quantidade: quantidadeEditingController.text,
                          valor: valorEditingController.text,                       
                        ));
                        Navigator.pop(context);
                      }
                    },
                )                
              ],
            ),
          ),
        ),
      ),
  
    );
  }

  textFormField(TextEditingController t, String label, String hint,
    IconData iconData, String initialValue) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: TextFormField(
          validator: (value){
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
          controller: t,
          //keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            prefixIcon: Icon(iconData),            
            hintText: label,
            border: 
              OutlineInputBorder(borderRadius: BorderRadius.circular(10))
          ),
        ),
      );
    }

    textFormFieldPhone(TextEditingController t, String label, String hint,
    IconData iconData, String initialValue) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: TextFormField(
          validator: (value){
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
          controller: t,
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            prefixIcon: Icon(iconData),            
            hintText: label,
            border: 
              OutlineInputBorder(borderRadius: BorderRadius.circular(10))
          ),
        ),
      );
    }

}
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
  TextEditingController descricaoEditingController = TextEditingController();
  TextEditingController prioridadeEditingController = TextEditingController();
  TextEditingController setorEditingController = TextEditingController();
  TextEditingController proprietarioEditingController = TextEditingController();
  TextEditingController localEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {    
    super.initState();
    //if you press the button to edit it must pass to true, 
    //instantiate the name and phone in its respective controller, (link them to each controller)
    if(widget.edit == true){
      descricaoEditingController.text = widget.produto.descricao;
      prioridadeEditingController.text = widget.produto.prioridade;
      setorEditingController.text = widget.produto.setor;
      proprietarioEditingController.text = widget.produto.proprietario;
      localEditingController.text = widget.produto.local;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.edit?"Editar Chamado":"Adiciona Chamado"),),
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
                textFormField(descricaoEditingController, "Descricao", "Enter Descricao",
                Icons.person, widget.edit ? widget.produto.descricao : "descricao"),
                textFormFieldPhone(prioridadeEditingController, "Prioridade", "Enter Prioridade", 
                Icons.person, widget.edit ? widget.produto.prioridade : "prioridade",),
                textFormFieldPhone(setorEditingController, "Setor", "Enter Setor", 
                Icons.person, widget.edit ? widget.produto.setor : "setor",),
                textFormFieldPhone(proprietarioEditingController, "Proprietario", "Enter Proprietario", 
                Icons.person, widget.edit ? widget.produto.proprietario : "proprietario",),
                textFormFieldPhone(localEditingController, "Local", "Enter Local", 
                Icons.person, widget.edit ? widget.produto.local : "local",),
                
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
                          descricao: descricaoEditingController.text,
                          prioridade: prioridadeEditingController.text,
                          setor: setorEditingController.text,
                          proprietario: proprietarioEditingController.text,
                          local: localEditingController.text,
                          id: widget.produto.id ));
                          Navigator.pop(context);
                      } else {
                        await ProdutoDatabaseProvider.db.addProdutoToDatabase(new Produto(
                          descricao: descricaoEditingController.text,
                          prioridade: prioridadeEditingController.text,
                          setor: setorEditingController.text,
                          proprietario: proprietarioEditingController.text,
                          local: localEditingController.text,                     
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
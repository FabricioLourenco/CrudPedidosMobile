import 'package:conectar_api/controllers/produtoController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  var controllerProduto = ProdutoController.produtoController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Formulario"),
      ),
      body:
      Obx(()=>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                        labelText: 'Produto',
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Por favor, insira umm Produto';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height:10),
                  TextFormField(
                    controller: _descricaoController,
                    decoration: InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Por favor, insira descrição produto';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height:10),
                  TextFormField(
                    controller: _precoController,
                    decoration: InputDecoration(
                        labelText: 'Preço',
                        border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Por favor, insira um valor';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: ()  {





                    },
                    child: const Text('Enviar'),
                  ),

                ],
              )
          ),

        ],
      )
      )
    );
  }
}
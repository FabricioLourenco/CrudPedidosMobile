import 'package:conectar_api/components/MenuComponent.dart';
import 'package:conectar_api/controllers/produtoController.dart';
import 'package:conectar_api/models/ProdutoModel.dart';
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
      drawer: MenuComponent(),
      body:
      Obx(()=>
        controllerProduto.isLoading.value?
        Center(child: CircularProgressIndicator(),) :
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
                    onPressed: ()  async {
                        if(_formKey.currentState!.validate()){
                          final produto = Produtomodel(
                              nome: _nomeController.text,
                              descricao: _descricaoController.text,
                              preco: double.tryParse(_precoController.text) ?? 0.0
                          );
                          
                         var response= true;
                          // await controllerProduto.salvar(produto);
                          
                         if(response != null || response !=false){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: 
                                      Row(
                                        children: [
                                          Icon(Icons.check, color: Colors.white,),
                                          SizedBox(width: 8,),
                                          Expanded(
                                            child: Text("Salvo com sucesso",
                                            style: TextStyle(color: Colors.white),),
                                          )
                                        ],
                                      ),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 2),
                                margin: EdgeInsets.all(10),
                              )
                            );
                         }
                          
                          
                        }





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
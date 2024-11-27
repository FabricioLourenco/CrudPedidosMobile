import 'package:conectar_api/controllers/produtoController.dart';
import 'package:conectar_api/models/ProdutoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/MenuComponent.dart';

class ListaProdutoScreen extends StatefulWidget {

  @override
  State<ListaProdutoScreen> createState() => _ListaProdutoScreenState();
}

class _ListaProdutoScreenState extends State<ListaProdutoScreen> {

  var controllerProduto =
      ProdutoController.produtoController;

  @override
  void initState(){
    super.initState();
    //Chama o metodo para listar produtos após
    // a construção do widget
      WidgetsBinding.instance.addPostFrameCallback((_){
        controllerProduto.listarProdutos();
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Lista Produtos"),
        ),
         drawer: MenuComponent(),
        body:
        Obx(()=>
        controllerProduto.isLoading.value?
        Center(child: CircularProgressIndicator(),) :
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[


          ],
        )
        )
    );
  }
}
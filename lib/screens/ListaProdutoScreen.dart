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
              ListView.builder(
                  itemCount: controllerProduto.produtos.length,
                  itemBuilder: (context, index){
                    final produto = controllerProduto.produtos[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          produto.nome,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          produto.descricao
                        ),
                        trailing: Text(
                          "R\$ ${produto.preco.toStringAsFixed(2)}"
                        ),
                      ),
                    );
                  }
              )


        )
    );
  }
}
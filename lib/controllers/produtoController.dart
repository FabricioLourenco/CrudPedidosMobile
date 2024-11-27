import 'package:conectar_api/models/ProdutoModel.dart';
import 'package:get/get.dart';

import '../services/produtoService.dart';

class ProdutoController extends GetxController{

  ProdutoService _produtoService = ProdutoService();

  var isLoading = false.obs;
  var produtos = <Produtomodel>[].obs;
  static ProdutoController get produtoController => Get.find();

  Future<dynamic> salvar (Produtomodel produtoModel) async{
    isLoading.value = true;
    var resposta = await _produtoService.salvaProduto(produtoModel);
    isLoading.value = false;
    update();
    return resposta;
  }

  Future<void> listarProdutos() async {
    //indica que carregar é verdadeiro
    isLoading.value = true;
    try{
      var lista = await _produtoService.listarProdutos();
      if(lista != null){
        produtos.assignAll(lista);
      }
      else{
        produtos.clear();
      }
    }
    catch(e){
      produtos.clear();
    }
    finally {
      isLoading.value = false;
      update();
    }
  }

}
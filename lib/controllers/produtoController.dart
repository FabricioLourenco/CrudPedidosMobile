import 'package:conectar_api/models/ProdutoModel.dart';
import 'package:get/get.dart';

import '../services/produtoService.dart';

class ProdutoController extends GetxController{

  ProdutoService _produtoService = ProdutoService();

  var isLoading = false.obs;
  static ProdutoController get produtoController
  => Get.find();

  Future<dynamic> salvar (Produtomodel produtoModel) async{
    isLoading.value = true;
    var resposta = await _produtoService.salvaProduto(produtoModel);
    isLoading.value = false;
    update();
    return resposta;
  }



}
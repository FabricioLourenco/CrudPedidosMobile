import 'package:conectar_api/models/LojaModel.dart';
import 'package:get/get.dart';

import '../services/lojaService.dart';

class LojaController extends GetxController{
  LojaService _lojaService = LojaService();

  var isLoading = false.obs;
  static LojaController get lojaController => Get.find();
  var lojas = <LojaModel>[].obs;

  Future<void> listarLojas() async {
    //indica que carregar é verdadeiro
    isLoading.value = true;
    try{
      var lista = await _lojaService.listarLojas();
      if(lista != null){
        lojas.assignAll(lista);
      }
      else{
        lojas.clear();
      }
    }
    catch(e){
      lojas.clear();
    }
    finally {
      isLoading.value = false;
      update();
    }
  }


}


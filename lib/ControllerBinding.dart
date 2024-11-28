import 'package:conectar_api/controllers/lojaController.dart';
import 'package:conectar_api/controllers/produtoController.dart';
import 'package:get/get.dart';

class ControllerBinding implements Bindings{
  @override
  void dependencies() {
      Get.lazyPut<ProdutoController>(() => ProdutoController());
      Get.lazyPut<LojaController>(() => LojaController());
  }

}
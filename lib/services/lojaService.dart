import 'dart:convert';

import 'package:conectar_api/models/LojaModel.dart';
import 'package:conectar_api/models/ProdutoModel.dart';
import 'package:http/http.dart' as http;
class LojaService{
  dynamic _response;
  String url ="http://localhost:8080/loja/salvar";
  ProdutoService(){
    _response = "";
  }

  Future<List<LojaModel>> listarLojas() async{
    try{
      _response = await http.get(
        Uri.parse("http://localhost:8080/loja/listar"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );
      //veridfica status resposta do servidor
      if(_response.statusCode == 200){
        List<dynamic> jsonListLojas =
        json.decode(utf8.decode(_response.bodyBytes));
        return
          jsonListLojas.map((item) => LojaModel.fromJson(item)).toList();
      }else{
        return [];
      }
    }catch(e){
      return [];
    }
  }


}
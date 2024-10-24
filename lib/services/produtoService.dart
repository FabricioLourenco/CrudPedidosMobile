import 'dart:convert';

import 'package:conectar_api/models/ProdutoModel.dart';
import 'package:http/http.dart' as http;
class ProdutoService{

  dynamic _response;
   String url ="http://localhost:8080/produto/salvar";
  ProdutoService(){
    _response = "";
  }

  Future<dynamic> salvaProduto(Produtomodel produto) async{
      _response = await http.post(Uri.parse(url),
        body: json.encode(produto.toJson()),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        }
      );
    if(_response.statusCode == 200 || _response.statusCode == 201){
      return Produtomodel.fromJson(json.decode(_response.body));
    }else{
      return false;
    }

  }


}
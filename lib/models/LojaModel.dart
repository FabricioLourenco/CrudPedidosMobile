import 'package:conectar_api/models/ProdutoModel.dart';

class LojaModel{
  final String id;
  final String razaoSocial;
  final String cnpj;
  // final  List<Produtomodel> produtos;

  LojaModel({
    required this.id,
    required this.razaoSocial,
    required this.cnpj,
    // required this.produtos
  });

  LojaModel.fromJson(Map<String, dynamic> json):
      id = json['id'] ?? '',
        razaoSocial = json['razaoSocial'] ?? '',
        cnpj = json['cnpj'] ?? '';



}
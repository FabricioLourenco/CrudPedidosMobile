import 'package:conectar_api/models/PedidoModel.dart';

class ClienteModel {
  final String id;
  final String nome;
  final String cpf;
  final String telefone;
  final String? endereco;
  final List<PedidoModel> pedidos;

  ClienteModel({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.telefone,
    this.endereco,
    required this.pedidos,
  });
  
  ClienteModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        nome = json['nome'] ?? '',
        cpf = json['cpf'] ?? '',
        telefone = json['telefone'] ?? '',
        endereco = json['endereco'],
        pedidos = (json['pedidos'] as List<dynamic>?)
            ?.map((pedido) => PedidoModel.fromJson(pedido))
            .toList() ??
            [];

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'cpf': cpf,
    'telefone': telefone,
    'endereco': endereco,
    'pedidos': pedidos.map((pedido) => pedido.toJson()).toList(),
  };
}

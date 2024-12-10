class PedidoModel {
  final String id;
  late final String descricao;
  double valor;
  String clienteId;
  String status; // Adicionado o campo 'status'

  PedidoModel({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.clienteId,
    this.status = 'Pendente', // Define 'Pendente' como valor padrão
  });

  // Método para criar um objeto PedidoModel a partir de um JSON
  PedidoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '', // Garante que 'id' sempre terá um valor
        descricao = json['descricao'] ?? '', // Garante que 'descricao' nunca será nula
        valor = (json['valor'] is num) ? json['valor'].toDouble() : 0.0, // Converte para double se possível
        clienteId = json['clienteId'] ?? '', // Garante que 'clienteId' nunca será nulo ou vazio
        status = json['status'] ?? 'Pendente'; // Garante que 'status' tenha um valor padrão

  // Método para converter um objeto PedidoModel para JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'descricao': descricao,
    'valor': valor,
    'clienteId': clienteId,
    'status': status, // Inclui 'status' no JSON gerado
  };
}

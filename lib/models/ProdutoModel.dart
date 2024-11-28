class Produtomodel{
  final String nome;
  final String descricao;
  double preco;
  String lojaId;

  Produtomodel({required this.nome,
    required this.descricao,
    required this.preco,
    required this.lojaId

  });

  Produtomodel.fromJson(
      Map<String, dynamic > json) :
      nome=json['nome'],
      descricao=json['descricao'],
      preco=json['preco'],
        lojaId=json['lojaId'] ?? "";

  Map<String, dynamic>toJson() => {
    'nome': nome,
    'descricao': descricao,
    'preco': preco,
    'lojaId': lojaId,
  };

}
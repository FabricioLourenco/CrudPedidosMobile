class Produtomodel{
  final String nome;
  final String descricao;
  double preco;

  Produtomodel({required this.nome,
    required this.descricao,
    required this.preco});

  Produtomodel.fromJson(
      Map<String, dynamic > json) :
      nome=json['nome'],
      descricao=json['descricao'],
      preco=json['preco'];

  Map<String, dynamic>toJson() => {
    'nome': nome,
    'descricao': descricao,
    'preco': preco,
  };

}
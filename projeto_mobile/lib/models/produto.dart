class Produto {
  String? firebaseId;
  final String nome;
  final String descricao;
  final double preco;
  final String? dataAtualizado; // opcional, string ISO

  Produto({
    this.firebaseId,
    required this.nome,
    required this.descricao,
    required this.preco,
    this.dataAtualizado,
  });

  factory Produto.fromJson(Map<String, dynamic> json, {String? id}) {
    return Produto(
      firebaseId: id,
      nome: json['nome'] ?? '',
      descricao: json['descricao'] ?? '',
      preco: (json['preco'] ?? 0).toDouble(),
      dataAtualizado: json['data_atualizado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'data_atualizado': dataAtualizado,
    };
  }
}

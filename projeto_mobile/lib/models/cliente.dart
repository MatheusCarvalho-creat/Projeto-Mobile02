class Cliente {
  String? firebaseId; // chave do Firebase
  final String nome;
  final String sobrenome;
  final String email;
  final int idade;
  final String? foto; // url opcional

  Cliente({
    this.firebaseId,
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.idade,
    this.foto,
  });

  factory Cliente.fromJson(Map<String, dynamic> json, {String? id}) {
    return Cliente(
      firebaseId: id,
      nome: json['nome'] ?? '',
      sobrenome: json['sobrenome'] ?? '',
      email: json['email'] ?? '',
      idade: (json['idade'] ?? 0) is int ? json['idade'] : int.parse((json['idade'] ?? '0').toString()),
      foto: json['foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'idade': idade,
      'foto': foto,
    };
  }
}

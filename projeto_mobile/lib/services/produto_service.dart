import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produto.dart';

class ProdutoService {
  final String baseUrl = 'URL';

  Future<List<Produto>> listarProdutos() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));
    if (response.statusCode == 200) {
      if (response.body == 'null') return [];
      final Map<String, dynamic> dados = json.decode(response.body);
      return dados.entries.map((e) => Produto.fromJson(e.value as Map<String, dynamic>, id: e.key)).toList();
    } else {
      throw Exception('Erro ao carregar produtos');
    }
  }

  Future<void> adicionarProduto(Produto produto) async {
    final response = await http.post(
      Uri.parse('$baseUrl.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produto.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao criar produto');
    }
  }

  Future<void> atualizarProduto(String firebaseId, Produto produto) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$firebaseId.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produto.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar produto');
    }
  }

  Future<void> removerProduto(String firebaseId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$firebaseId.json'),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao remover produto');
    }
  }
}

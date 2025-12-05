import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cliente.dart';

class ClienteService {
  // substituir pela sua URL do Realtime DB (sem / no final)
  final String baseUrl = 'YOUR_FIREBASE_DB_URL';

  Future<List<Cliente>> listarClientes() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));
    if (response.statusCode == 200) {
      if (response.body == 'null') return [];
      final Map<String, dynamic> dados = json.decode(response.body);
      return dados.entries.map((e) => Cliente.fromJson(e.value as Map<String, dynamic>, id: e.key)).toList();
    } else {
      throw Exception('Erro ao carregar clientes');
    }
  }

  Future<void> adicionarCliente(Cliente cliente) async {
    final response = await http.post(
      Uri.parse('$baseUrl.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cliente.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao criar cliente');
    }
  }

  Future<void> atualizarCliente(String firebaseId, Cliente cliente) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$firebaseId.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cliente.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar cliente');
    }
  }

  Future<void> removerCliente(String firebaseId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$firebaseId.json'),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao remover cliente');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:projeto_mobile/models/cliente.dart';
import 'package:projeto_mobile/services/cliente_service.dart';

class ClientesScreen extends StatefulWidget {
  @override
  _ClientesScreenState createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  late Future<List<Cliente>> _clientesFuture;
  final ClienteService _service = ClienteService();

  @override
  void initState() {
    super.initState();
    _clientesFuture = _service.listarClientes();
  }

  void _removerCliente(String firebaseId) async {
    try {
      await _service.removerCliente(firebaseId);
      setState(() {
        _clientesFuture = _service.listarClientes();
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao remover cliente')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clientes')),
      body: FutureBuilder<List<Cliente>>(
        future: _clientesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Erro: ${snapshot.error}'));
          if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text('Nenhum cliente encontrado.'));
          final clientes = snapshot.data!;
          return ListView.builder(
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              final cliente = clientes[index];
              return ListTile(
                title: Text('${cliente.nome} ${cliente.sobrenome}'),
                subtitle: Text(cliente.email),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: cliente.firebaseId == null ? null : () => _removerCliente(cliente.firebaseId!),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/cliente/form', arguments: cliente).then((value) {
                    setState(() {
                      _clientesFuture = _service.listarClientes();
                    });
                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/cliente/form').then((value) {
          setState(() {
            _clientesFuture = _service.listarClientes();
          });
        }),
      ),
    );
  }
}

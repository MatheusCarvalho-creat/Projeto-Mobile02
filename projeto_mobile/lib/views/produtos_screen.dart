import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../services/produto_service.dart';

class ProdutosScreen extends StatefulWidget {
  @override
  _ProdutosScreenState createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  late Future<List<Produto>> _produtosFuture;
  final ProdutoService _service = ProdutoService();

  @override
  void initState() {
    super.initState();
    _produtosFuture = _service.listarProdutos();
  }

  void _recarregar() => setState(() => _produtosFuture = _service.listarProdutos());

  void _remover(String firebaseId) async {
    try {
      await _service.removerProduto(firebaseId);
      _recarregar();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao remover produto')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Produtos')),
      body: FutureBuilder<List<Produto>>(
        future: _produtosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Erro: ${snapshot.error}'));
          if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text('Nenhum produto cadastrado.'));
          final produtos = snapshot.data!;
          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final p = produtos[index];
              return ListTile(
                title: Text(p.nome),
                subtitle: Text(p.descricao),
                trailing: IconButton(icon: Icon(Icons.delete), onPressed: p.firebaseId==null?null:()=>_remover(p.firebaseId!)),
                onTap: () => Navigator.pushNamed(context, '/produto/form', arguments: p).then((_)=>_recarregar()),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/produto/form').then((_)=>_recarregar()),
      ),
    );
  }
}

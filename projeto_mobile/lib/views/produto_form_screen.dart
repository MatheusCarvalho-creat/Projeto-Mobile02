import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../services/produto_service.dart';

class ProdutoFormScreen extends StatefulWidget {
  @override
  _ProdutoFormScreenState createState() => _ProdutoFormScreenState();
}

class _ProdutoFormScreenState extends State<ProdutoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProdutoService _service = ProdutoService();

  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();

  Produto? _produtoAtual;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Produto && _produtoAtual == null) {
      _produtoAtual = args;
      _nomeController.text = args.nome;
      _descricaoController.text = args.descricao;
      _precoController.text = args.preco.toString();
    }
  }

  void _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final novo = Produto(
      firebaseId: _produtoAtual?.firebaseId,
      nome: _nomeController.text,
      descricao: _descricaoController.text,
      preco: double.tryParse(_precoController.text) ?? 0,
      dataAtualizado: DateTime.now().toIso8601String(),
    );

    try {
      if (_produtoAtual == null) {
        await _service.adicionarProduto(novo);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Produto criado')));
      } else {
        await _service.atualizarProduto(_produtoAtual!.firebaseId!, novo);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Produto atualizado')));
      }
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_produtoAtual == null ? 'Adicionar Produto' : 'Editar Produto')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _nomeController, decoration: InputDecoration(labelText: 'Nome'), validator: (v)=> (v==null||v.isEmpty)?'Obrigatório':null),
              TextFormField(controller: _descricaoController, decoration: InputDecoration(labelText: 'Descrição')),
              TextFormField(controller: _precoController, decoration: InputDecoration(labelText: 'Preço'), keyboardType: TextInputType.number, validator: (v)=> (v==null||double.tryParse(v)==null)?'Número inválido':null),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _salvar, child: Text(_produtoAtual==null?'Salvar':'Atualizar')),
            ],
          ),
        ),
      ),
    );
  }
}

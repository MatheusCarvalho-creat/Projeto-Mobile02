import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/cliente.dart';
import '../services/cliente_service.dart';

class ClienteFormScreen extends StatefulWidget {
  @override
  _ClienteFormScreenState createState() => _ClienteFormScreenState();
}

class _ClienteFormScreenState extends State<ClienteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ClienteService _service = ClienteService();

  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _idadeController = TextEditingController();
  final _fotoController = TextEditingController();

  Cliente? _clienteAtual;

  File? _imagemSelecionada;
  final ImagePicker _picker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Cliente && _clienteAtual == null) {
      _clienteAtual = args;
      _nomeController.text = args.nome;
      _sobrenomeController.text = args.sobrenome;
      _emailController.text = args.email;
      _idadeController.text = args.idade.toString();
      _fotoController.text = args.foto ?? '';

      // Se a foto existe localmente, carrega para visualização
      if (args.foto != null && File(args.foto!).existsSync()) {
        _imagemSelecionada = File(args.foto!);
      }
    }
  }

  Future<void> _selecionarFotoGaleria() async {
    final XFile? imagem = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (imagem != null) {
      setState(() {
        _imagemSelecionada = File(imagem.path);
        _fotoController.text = imagem.path;
      });
    }
  }

  Future<void> _tirarFotoCamera() async {
    final XFile? imagem = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );

    if (imagem != null) {
      setState(() {
        _imagemSelecionada = File(imagem.path);
        _fotoController.text = imagem.path;
      });
    }
  }

  void _salvarCliente() async {
    if (!_formKey.currentState!.validate()) return;

    final novoCliente = Cliente(
      firebaseId: _clienteAtual?.firebaseId,
      nome: _nomeController.text,
      sobrenome: _sobrenomeController.text,
      email: _emailController.text,
      idade: int.tryParse(_idadeController.text) ?? 0,
      foto: _fotoController.text.isNotEmpty ? _fotoController.text : null,
    );

    try {
      if (_clienteAtual == null) {
        await _service.adicionarCliente(novoCliente);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cliente adicionado')),
        );
      } else {
        await _service.atualizarCliente(_clienteAtual!.firebaseId!, novoCliente);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cliente atualizado')),
        );
      }

      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_clienteAtual == null ? 'Adicionar Cliente' : 'Editar Cliente'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              
              // ------------------------ FOTO ------------------------
              Text("Foto do Cliente", style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),

              Center(
                child: _imagemSelecionada != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.file(
                          _imagemSelecionada!,
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      )
                    : CircleAvatar(
                        radius: 70,
                        child: Icon(Icons.person, size: 60),
                      ),
              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _selecionarFotoGaleria,
                    icon: Icon(Icons.photo),
                    label: Text("Galeria"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _tirarFotoCamera,
                    icon: Icon(Icons.camera_alt),
                    label: Text("Câmera"),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // ------------------------ CAMPOS ------------------------
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
              ),

              TextFormField(
                controller: _sobrenomeController,
                decoration: InputDecoration(labelText: 'Sobrenome'),
              ),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                    (v == null || !v.contains('@')) ? 'Email inválido' : null,
              ),

              TextFormField(
                controller: _idadeController,
                decoration: InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    (v == null || int.tryParse(v) == null) ? 'Número inválido' : null,
              ),

              SizedBox(height: 20),

              // ------------------------ BOTÃO ------------------------
              ElevatedButton(
                onPressed: _salvarCliente,
                child: Text(_clienteAtual == null ? 'Salvar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

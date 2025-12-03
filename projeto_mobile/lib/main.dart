import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/clientes_screen.dart';
import 'views/produtos_screen.dart';
import 'views/cliente_form_screen.dart';
import 'views/produto_form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio Final',
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/cliente': (context) => ClientesScreen(),
        '/produto': (context) => ProdutosScreen(),
        '/cliente/form': (context) => ClienteFormScreen(),
        '/produto/form': (context) => ProdutoFormScreen(),
      },
    );
  }
}

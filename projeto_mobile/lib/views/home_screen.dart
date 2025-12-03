import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desafio Final'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Clientes'),
                subtitle: Text('Gerenciar clientes (CRUD)'),
                onTap: () => Navigator.pushNamed(context, '/cliente'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Produtos'),
                subtitle: Text('Gerenciar produtos (CRUD)'),
                onTap: () => Navigator.pushNamed(context, '/produto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro+: Clientes e Produtos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // --- Card Clientes ---
              SizedBox(
                width: size.width * 0.85,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    leading: Icon(Icons.people, size: 40, color: Colors.blue),
                    title: Text(
                      'Clientes',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Gerenciar clientes',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/cliente'),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Card Produtos ---
              SizedBox(
                width: size.width * 0.85,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    leading: Icon(Icons.shopping_cart,
                        size: 40, color: Colors.green),
                    title: Text(
                      'Produtos',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Gerenciar produtos',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/produto'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

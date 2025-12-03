# Desafio Final - Desenvolvimento Mobile II (Flutter + Firebase Realtime DB)

## Estrutura
- lib/models
- lib/services
- lib/views
- main.dart

## Dependências
- http

## Configurar Firebase Realtime Database
1. Crie um projeto no Firebase Console.
2. No Realtime Database, crie um banco e selecione modo **insecure** (somente para testes) ou configure regras com autenticação.
3. Copie a URL do Realtime Database (ex.: https://meu-projeto-default-rtdb.firebaseio.com).
4. Substitua `YOUR_FIREBASE_DB_URL` nos services (`cliente_service.dart` e `produto_service.dart`) pela sua URL (sem `/` extra).

## Executar
1. `flutter pub get`
2. `flutter run` (ou execute pelo VSCode/Android Studio)

## Observações
- Rotas:
  - `/` home
  - `/cliente` lista clientes
  - `/cliente/form` formulário cliente
  - `/produto` lista produtos
  - `/produto/form` formulário produto
- O campo `firebaseId` salva a chave do Realtime DB e é usado para PUT/DELETE.

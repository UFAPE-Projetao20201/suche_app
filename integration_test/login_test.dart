import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:suche_app/main.dart';
import 'package:flutter/material.dart';
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("successful login", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(user: '',));
    expect(find.text('Suche'), findsOneWidget);
    Finder email = find.byType(TextField).at(0);
    await tester.enterText(email, 'teste@api.com');
    Finder senha = find.byType(TextField).at(1);
    await tester.enterText(senha, '12345678');
    await tester.tap(find.text('ENTRAR'));
    await tester.pump(new Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets("trying to login when fields are not filled", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(user: '',));
    expect(find.text('Suche'), findsOneWidget);
    Finder email = find.byType(TextField).at(0);
    await tester.enterText(email, '');
    Finder senha = find.byType(TextField).at(1);
    await tester.enterText(senha, '');
    await tester.tap(find.text('ENTRAR'));
    await tester.pump(new Duration(seconds: 5));
    expect(find.text('O e-mail é um campo obrigatório'), findsOneWidget);
    expect(find.text('A senha é um campo obrigatório'), findsOneWidget);
    //await tester.pumpAndSettle();
  });

  testWidgets("trying to login when email does not exist in database", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(user: '',));
    expect(find.text('Suche'), findsOneWidget);
    Finder email = find.byType(TextField).at(0);
    await tester.enterText(email, 'teste@api.c');
    Finder senha = find.byType(TextField).at(1);
    await tester.enterText(senha, '123456789');
    await tester.tap(find.text('ENTRAR'));
    await tester.pump(new Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.pump(new Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('Usuário não encontrado!'), findsOneWidget);
  });

  testWidgets("trying to login when password does not match the user's password", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(user: '',));
    expect(find.text('Suche'), findsOneWidget);
    Finder email = find.byType(TextField).at(0);
    await tester.enterText(email, 'teste@api.com');
    Finder senha = find.byType(TextField).at(1);
    await tester.enterText(senha, '123456789');
    await tester.tap(find.text('ENTRAR'));
    await tester.pump(new Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.pump(new Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('E-mail ou senha inválidos!'), findsOneWidget);
  });
}
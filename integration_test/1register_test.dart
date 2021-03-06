import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:suche_app/main.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Cadastro com sucesso", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(user: '',));
    expect(find.text('Suche'), findsOneWidget);
    await tester.tap(find.byKey(Key("cadastre-se")));
    await tester.pump(new Duration(seconds: 2));
    await tester.pumpAndSettle();
    await tester.pump(new Duration(seconds: 2));
    Finder email = find.byType(TextField).at(0);
    await tester.enterText(email, 'integration@teste.com');
    await tester.pump(new Duration(seconds: 1));
    Finder nome = find.byType(TextField).at(1);
    await tester.enterText(nome, 'Acceptance');
    await tester.pump(new Duration(seconds: 1));
    Finder sobrenome = find.byType(TextField).at(2);
    await tester.enterText(sobrenome, 'Tester');
    await tester.pump(new Duration(seconds: 1));
    Finder telefone = find.byType(TextField).at(3);
    await tester.enterText(telefone, '85995263589');
    await tester.pump(new Duration(seconds: 1));
    Finder drop = find.byKey(Key("dropgenero"));
    await tester.tap(drop);
    await tester.pump();
    await tester.pump(Duration(seconds: 1));
    await tester.tap(find.text('Masculino').last);
    await tester.pump();
    await tester.pump(Duration(seconds: 4));
    Finder data = find.byType(TextField).at(4);
    await tester.tap(data);
    await tester.pump();
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '04/11/2001');
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();
    Finder senha = find.byType(TextField).at(5);
    await tester.enterText(senha, '12345678');
    await tester.drag(find.byKey(Key('ScrollCadastro')), const Offset(0.0, -300));
    await tester.pump();
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.text('CADASTRAR'));
    await tester.pump(new Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('SucheApp'), findsOneWidget);
  });

  testWidgets("Cadastro com campos em branco", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(user: '',));
    expect(find.text('Suche'), findsOneWidget);
    await tester.tap(find.byKey(Key("cadastre-se")));
    await tester.pump(new Duration(seconds: 2));
    await tester.pumpAndSettle();
    await tester.pump(new Duration(seconds: 2));
    await tester.drag(find.byKey(Key('ScrollCadastro')), const Offset(0.0, -300));
    await tester.pump();
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.text('CADASTRAR'));
    await tester.pump(new Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('O nome ?? um campo obrigat??rio'), findsOneWidget);
    expect(find.text('O sobrenome ?? um campo obrigat??rio'), findsOneWidget);
    expect(find.text('O g??nero ?? um campo obrigat??rio'), findsOneWidget);
    expect(find.text('A data ?? um campo obrigat??rio'), findsOneWidget);
    expect(find.text('A senha ?? um campo obrigat??rio'), findsOneWidget);
    await tester.drag(find.byKey(Key('ScrollCadastro')), const Offset(0.0, 300));
    await tester.pump();
    await tester.pump(new Duration(seconds: 2));
    expect(find.text('O e-mail ?? um campo obrigat??rio'), findsOneWidget);
  });

  testWidgets("Cadastro com campos em inv??lidos", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(user: '',));
    expect(find.text('Suche'), findsOneWidget);
    await tester.tap(find.byKey(Key("cadastre-se")));
    await tester.pump(new Duration(seconds: 2));
    await tester.pumpAndSettle();
    await tester.pump(new Duration(seconds: 2));
    Finder email = find.byType(TextField).at(0);
    await tester.enterText(email, 'integration');
    await tester.pump(new Duration(seconds: 1));
    Finder telefone = find.byType(TextField).at(3);
    await tester.enterText(telefone, '8599');
    await tester.pump(new Duration(seconds: 1));
    expect(find.text('Insira um e-mail v??lido'), findsOneWidget);
    expect(find.text('N??mero de telefone inv??lido'), findsOneWidget);
  });

  testWidgets("Cadastro com dados repetidos", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(user: '',));
    expect(find.text('Suche'), findsOneWidget);
    await tester.tap(find.byKey(Key("cadastre-se")));
    await tester.pump(new Duration(seconds: 2));
    await tester.pumpAndSettle();
    await tester.pump(new Duration(seconds: 2));
    Finder email = find.byType(TextField).at(0);
    await tester.enterText(email, 'integration@teste.com');
    await tester.pump(new Duration(seconds: 1));
    Finder nome = find.byType(TextField).at(1);
    await tester.enterText(nome, 'Acceptance');
    await tester.pump(new Duration(seconds: 1));
    Finder sobrenome = find.byType(TextField).at(2);
    await tester.enterText(sobrenome, 'Tester');
    await tester.pump(new Duration(seconds: 1));
    Finder telefone = find.byType(TextField).at(3);
    await tester.enterText(telefone, '85995263589');
    await tester.pump(new Duration(seconds: 1));
    Finder drop = find.byKey(Key("dropgenero"));
    await tester.tap(drop);
    await tester.pump();
    await tester.pump(Duration(seconds: 1));
    await tester.tap(find.text('Masculino').last);
    await tester.pump();
    await tester.pump(Duration(seconds: 4));
    Finder data = find.byType(TextField).at(4);
    await tester.tap(data);
    await tester.pump();
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '04/11/2001');
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();
    Finder senha = find.byType(TextField).at(5);
    await tester.enterText(senha, '12345678');
    await tester.drag(find.byKey(Key('ScrollCadastro')), const Offset(0.0, -300));
    await tester.pump();
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.text('CADASTRAR'));
    await tester.pump(new Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.pump(new Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('Email ou Telefone j?? existem no sistema! (400)'), findsOneWidget);
  });
}
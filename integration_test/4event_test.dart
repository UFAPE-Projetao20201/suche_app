import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:suche_app/main.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Criar evento online com sucesso", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(user: '',));
    expect(find.text('Suche'), findsOneWidget);
    Finder email = find.byType(TextField).at(0);
    await tester.enterText(email, 'integration@teste.com');
    Finder senha = find.byType(TextField).at(1);
    await tester.enterText(senha, '12345678');
    await tester.tap(find.text('ENTRAR'));
    await tester.pump(new Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('SucheApp'), findsOneWidget);
    await tester.tap(find.byIcon(Mdi.partyPopper));
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.byKey(Key("ButtonCadastro")));
    await tester.pump(new Duration(seconds: 2));
    Finder nome = find.byType(TextField).at(0);
    await tester.enterText(nome, 'Evento de Teste');
    await tester.pump(new Duration(seconds: 1));
    Finder descricao = find.byType(TextField).at(1);
    await tester.enterText(descricao, 'Testando evento online');
    await tester.pump(new Duration(seconds: 1));
    Finder categoria = find.byKey(Key("dropcategoriacadastro"));
    await tester.tap(categoria);
    await tester.pump();
    await tester.pump(Duration(seconds: 1));
    await tester.tap(find.text('Artes').last);
    await tester.pump();
    await tester.pump(Duration(seconds: 4));
    Finder keywords = find.byType(TextField).at(2);
    await tester.enterText(keywords, 'testando,app');
    await tester.pump(new Duration(seconds: 1));
    Finder data = find.byType(TextField).at(3);
    await tester.tap(data);
    await tester.pump();
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '04/07/2022');
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();

    Finder preco = find.byType(TextField).at(4);
    await tester.enterText(preco, '200');
    await tester.pump(new Duration(seconds: 1));

    Finder link = find.byType(TextField).at(5);
    await tester.enterText(link, 'teste.com');

    await tester.drag(find.byKey(Key('ScrollCadastroEvento')), const Offset(0.0, -300));
    await tester.pump();
    await tester.pump(new Duration(seconds: 2));

    Finder tipoevento = find.byKey(Key("tipoevento"));
    await tester.tap(tipoevento);
    await tester.pump();
    await tester.pump(Duration(seconds: 1));
    await tester.tap(find.text('Online').last);
    await tester.pump();
    await tester.pump(Duration(seconds: 4));

    await tester.tap(find.text('CONTINUAR'));
    await tester.pump(new Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.text('Evento criado com sucesso!'), findsOneWidget);
  });

  testWidgets("Criar evento presencial com sucesso", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(user: '',));
    expect(find.text('Suche'), findsOneWidget);
    Finder email = find.byType(TextField).at(0);
    await tester.enterText(email, 'integration@teste.com');
    Finder senha = find.byType(TextField).at(1);
    await tester.enterText(senha, '12345678');
    await tester.tap(find.text('ENTRAR'));
    await tester.pump(new Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('SucheApp'), findsOneWidget);
    await tester.tap(find.byIcon(Mdi.partyPopper));
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.byKey(Key("ButtonCadastro")));
    await tester.pump(new Duration(seconds: 2));
    Finder nome = find.byType(TextField).at(0);
    await tester.enterText(nome, 'Outro Evento de Teste');
    await tester.pump(new Duration(seconds: 1));
    Finder descricao = find.byType(TextField).at(1);
    await tester.enterText(descricao, 'Testando evento presencial');
    await tester.pump(new Duration(seconds: 1));
    Finder categoria = find.byKey(Key("dropcategoriacadastro"));
    await tester.tap(categoria);
    await tester.pump();
    await tester.pump(Duration(seconds: 1));
    await tester.tap(find.text('Filme').last);
    await tester.pump();
    await tester.pump(Duration(seconds: 4));
    Finder keywords = find.byType(TextField).at(2);
    await tester.enterText(keywords, 'presencial,app');
    await tester.pump(new Duration(seconds: 1));
    Finder data = find.byType(TextField).at(3);
    await tester.tap(data);
    await tester.pump();
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '04/07/2022');
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();

    Finder preco = find.byType(TextField).at(4);
    await tester.enterText(preco, '0');
    await tester.pump(new Duration(seconds: 1));

    Finder link = find.byType(TextField).at(5);
    await tester.enterText(link, 'testepresencial.com');

    await tester.drag(find.byKey(Key('ScrollCadastroEvento')), const Offset(0.0, -300));
    await tester.pump();
    await tester.pump(new Duration(seconds: 2));

    Finder tipoevento = find.byKey(Key("tipoevento"));
    await tester.tap(tipoevento);
    await tester.pump();
    await tester.pump(Duration(seconds: 1));
    await tester.tap(find.text('Presencial').last);
    await tester.pump();
    await tester.pump(Duration(seconds: 4));

    await tester.tap(find.text('CONTINUAR'));
    await tester.pump(new Duration(seconds: 5));
    await tester.pumpAndSettle();

    Finder rua = find.byType(TextField).at(6);
    await tester.enterText(rua, 'Rua Central');
    Finder numero = find.byType(TextField).at(7);
    await tester.enterText(numero, '217');
    Finder cidade = find.byType(TextField).at(8);
    await tester.enterText(cidade, 'Recife');
    Finder CEP = find.byType(TextField).at(9);
    await tester.enterText(CEP, '43326781');

    await tester.tap(find.text('CONTINUAR').last);
    await tester.pump(new Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('Evento criado com sucesso!'), findsOneWidget);
  });
}
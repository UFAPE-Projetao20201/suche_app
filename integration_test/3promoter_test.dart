import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:suche_app/main.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Torne-se Promoter", (WidgetTester tester) async {
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
    await tester.tap(find.byIcon(Mdi.account));
    await tester.pump(new Duration(seconds: 2));
    await tester.tap(find.byIcon(Icons.approval));
    await tester.pump(new Duration(seconds: 1));
    await tester.enterText(find.byType(TextField), "95634125677");
    await tester.pump(new Duration(seconds: 1));
    await tester.tap(find.text('ATUALIZAR'));
    await tester.pump(new Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.pump(new Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Dados atualizados, faça seu login novamente.'), findsOneWidget);

  });
}
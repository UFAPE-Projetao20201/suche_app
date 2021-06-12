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
}
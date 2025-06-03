import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_app/app.dart';

void main() {
  testWidgets('CryptoListScreen should display a search TextField', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp()); // Removido o 'const'

    // Verifique se o TextField de busca está presente
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search Cryptos (e.g., BTC,ETH)'), findsOneWidget);

    // Verifique se a AppBar contém o título correto
    expect(find.text('Crypto List'), findsOneWidget);
  });

  testWidgets(
    'CryptoListScreen should display a CircularProgressIndicator initially',
    (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp()); // Removido o 'const'

      // Verifique se o CircularProgressIndicator está presente inicialmente (durante o carregamento)
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Simule a espera pelo carregamento (você pode precisar ajustar dependendo da lógica de carregamento)
      await tester.pumpAndSettle();

      // Verifique se o CircularProgressIndicator desaparece após o carregamento
      expect(find.byType(CircularProgressIndicator), findsNothing);
    },
  );
}

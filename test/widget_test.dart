import 'package:flutter_test/flutter_test.dart';
import 'package:zoko_marketplace/app/zoko_marketplace_app.dart';

void main() {
  testWidgets('Auth flow opens marketplace home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ZokoMarketplaceApp());

    expect(find.text('Welcome to Zoko Marketplace'), findsOneWidget);
    expect(find.text('I need a professional'), findsOneWidget);

    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.text('Create account'), findsWidgets);

    await tester.tap(find.text('Create account').last);
    await tester.pumpAndSettle();

    expect(
      find.text('Find trusted professionals for every job.'),
      findsOneWidget,
    );

    await tester.ensureVisible(find.text('Earn with Zoko'));
    expect(find.text('Earn with Zoko'), findsOneWidget);
  });
}

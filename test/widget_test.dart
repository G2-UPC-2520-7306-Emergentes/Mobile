// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/app/app_bootstrap.dart';

void main() {
  testWidgets('Home screen renders primary actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AppBootstrap());
    await tester.pump();

    expect(find.text("Scan your product's QR code."), findsOneWidget);
    expect(find.text('Scan QR Code'), findsOneWidget);

    await tester.tap(find.text('Scan QR Code'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.textContaining('lector de QR'), findsOneWidget);
  });
}

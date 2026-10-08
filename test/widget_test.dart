import 'package:flutter_test/flutter_test.dart';
import 'package:ev_service/main.dart';

void main() {
  testWidgets('EV-SERVICE inicia correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(const EVServiceApp());

    expect(find.text('EV SERVICE'), findsOneWidget);
  });
}
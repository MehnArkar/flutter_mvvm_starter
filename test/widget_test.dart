import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvvm_starter/app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}

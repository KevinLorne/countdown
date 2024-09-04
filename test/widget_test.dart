import 'package:countdown/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App initialization and MainMenu display',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CountdownGame());

    expect(find.text('Countdown Game'), findsOneWidget);
    expect(find.text('Start Game'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Instructions'), findsOneWidget);
    expect(find.text('View Scores'), findsOneWidget);
  });
}
